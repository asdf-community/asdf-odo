#!/usr/bin/env bash

set -euo pipefail

if [[ "${ASDF_ODO_VERBOSE:-false}" == "true" ]]; then
  set -x
fi

GH_REPO="https://github.com/redhat-developer/odo"
TOOL_NAME="odo"
TOOL_TEST="odo version"

ansi() {
  if [ -n "$TERM" ]; then
    # see if terminal supports colors...
    local ncolors=$(tput colors)
    if test -n "$ncolors" && test $ncolors -ge 8; then
      echo -e "\e[${1}m${*:2}\e[0m"
    else
      echo -e ${*:2}
    fi
  else
    echo -e ${*:2}
  fi
}

bold() {
  ansi 1 "$@"
}

italic() {
  ansi 3 "$@"
}

strikethrough() {
  ansi 9 "$@"
}

underline() {
  ansi 4 "$@"
}

blue() {
  ansi 34 "$@"
}

red() {
  ansi 31 "$@"
}

fail() {
  red "asdf-$TOOL_NAME: $*"
  exit 1
}

log_verbose() {
  if [[ "${ASDF_ODO_VERBOSE:-false}" == "true" ]]; then
    italic "[debug] $*"
  fi
}

uname_os() {
  os=$(uname -s | tr '[:upper:]' '[:lower:]')

  case "$os" in
  msys* | cygwin* | mingw*)
    os='windows'
    ;;
  esac

  echo "$os"
}

uname_arch() {
  arch=$(uname -m)
  case $arch in
  x86_64) arch="amd64" ;;
  x86 | i686 | i386) arch="386" ;;
  aarch64) arch="arm64" ;;
  armv5*) arch="armv5" ;;
  armv6*) arch="armv6" ;;
  armv7*) arch="armv7" ;;
  esac
  echo "$arch"
}

curl_opts=(-fsSL -A "\"asdf-$TOOL_NAME ($(uname_os)/$(uname_arch))\"")

# NOTE: You might want to remove this if odo is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  # By default we simply list the tag names from GitHub releases.
  # Change this function if odo has other means of determining installable versions.
  list_github_tags
}

download_ref() {
  local dl_dir gh_repo gh_ref
  dl_dir="$1"

  if [[ "$2" == "https://github.com/"* ]]; then
    gh_repo="$2"
  else
    gh_repo="https://github.com/$2"
  fi

  gh_ref="$3"

  local file_dl_dir extraction_dir extraction_tmp_dir
  file_dl_dir="$dl_dir/dl"
  extraction_dir="$dl_dir/src"
  extraction_tmp_dir="$dl_dir/tmp"
  mkdir -p "$dl_dir" "$file_dl_dir" "$extraction_tmp_dir"

  local url filename
  url="${gh_repo}/archive/${gh_ref}.zip"
  filename="$file_dl_dir/src.zip"
  [ -f "$filename" ] || (
    echo "* Downloading source code archive for $TOOL_NAME (ref: $gh_ref)..."
    log_verbose "Download URL $url, using curl options: '${curl_opts[@]}'"
    curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
  )

  rm -rf "$extraction_dir" "$extraction_tmp_dir"
  mkdir -p "$extraction_dir"
  echo "* Extracting file $filename to $extraction_tmp_dir..."
  log_verbose "Extracting to $extraction_tmp_dir"
  unzip -q "$filename" -d "$extraction_tmp_dir" || fail "Could not extract file $filename to $extraction_tmp_dir"
  log_verbose "Moving everything from to ${extraction_tmp_dir}/${TOOL_NAME}-<ref> to ${extraction_dir}"
  mv "${extraction_tmp_dir}/${TOOL_NAME}-"*/* "${extraction_dir}"
  rm -rf "${extraction_tmp_dir}" "$filename"
}

download_release() {
  local os_arch os arch version filename url

  if [ -n "${ASDF_ODO_BINARY_OS_ARCH:-}" ]; then
    os_arch="$ASDF_ODO_BINARY_OS_ARCH"
    log_verbose "Using pre-defined ASDF_ODO_BINARY_OS_ARCH environment variable: $ASDF_ODO_BINARY_OS_ARCH"
  else
    os=${ASDF_ODO_BINARY_OS:-"$(uname_os)"}
    log_verbose "Using Operating System: $os"
    arch=${ASDF_ODO_BINARY_ARCH:-"$(uname_arch)"}
    log_verbose "Using Processor Architecture: $arch"
    os_arch="${os}-${arch}"
  fi

  version="$1"
  filename="$2"

  local binaryExtension
  if [[ "$os_arch" == "windows-"* ]]; then
    binaryExtension=".exe"
  else
    binaryExtension=""
  fi

  # versions with a '-' need to be replaced with '~' in the download URL
  local versionForDl=$(echo "$version" | tr '-' '~')
  local urlForVersion="https://developers.redhat.com/content-gateway/rest/mirror/pub/openshift-v4/clients/$TOOL_NAME/v${versionForDl}"
  local toolBinaryNameWithExtension="$TOOL_NAME-${os_arch}${binaryExtension}"
  url="${urlForVersion}/${toolBinaryNameWithExtension}"

  echo "* Downloading $TOOL_NAME release $version, for $os_arch..."
  log_verbose "Download URL: $url, using curl options: '${curl_opts[@]}'"
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
  log_verbose "Downloaded file and saved it to $filename"

  if [[ "${ASDF_ODO_CHECKS_SKIP_FILE_CHECKSUM:-false}" != "true" ]]; then
    echo "* Verifying filename integrity..."
    shaurl="${url}.sha256"
    log_verbose "Download URL: $shaurl, using curl options: '${curl_opts[@]}'"
    shafilename="$filename.sha256"
    curl "${curl_opts[@]}" -o "$shafilename" -C - "$shaurl" || fail "Could not download $shaurl"
    # Issue with empty checksum file: https://github.com/rm3l/asdf-odo/issues/10
    [ -s "$shafilename" ] ||
      (log_verbose "Checksum file is empty => fallback to the root sha256sum.txt file" &&
        curl "${curl_opts[@]}" "${urlForVersion}/sha256sum.txt" |
        grep "$toolBinaryNameWithExtension" |
          grep -Ev "(\.tar\.gz|\.zip)" |
          awk '{print $1}' >"$shafilename")
    (echo "$(<$shafilename)  $filename" | shasum -a 256 --check) || fail "Could not check integrity of downloaded file"
  fi

  chmod a+x "$filename"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  local tool_cmd
  tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"

  log_verbose "install_path set to $install_path"

  (
    mkdir -p "$install_path"/bin
    if [[ "$install_type" == "ref" ]]; then
      cd "$ASDF_DOWNLOAD_PATH/src"
      local git_commit_for_version
      if [[ "${ASDF_GITHUB_REPO_FOR_ODO:-}" == "" ]]; then
        git_commit_for_version="${version}"
      else
        git_commit_for_version="${version}@${ASDF_GITHUB_REPO_FOR_ODO}"
      fi
      log_verbose "Building from source: $ASDF_DOWNLOAD_PATH/src"
      GITCOMMIT="${git_commit_for_version}" make bin
      mv "./$tool_cmd" "$install_path"/bin
    else
      mkdir -p "$install_path"
      cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"
    fi
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while building and/or installing $TOOL_NAME $version"
  )

  (
    # Assert odo executable exists.
    log_verbose "Testing that executable expected is really there at $install_path/bin/$tool_cmd"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    local msg
    msg="$TOOL_NAME $version installation was successful! Run: asdf <global | local> $TOOL_NAME"
    if [[ "$install_type" == "ref" ]]; then
      echo "$msg ref:${version}"
    else
      echo "$msg ${version}"
    fi
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while building and/or installing $TOOL_NAME $version"
  )
}
