#!/usr/bin/env bash

set -euo pipefail

if [[ "${ASDF_ODO_VERBOSE:-false}" == "true" ]]; then
  set -x
fi

current_script_path=${BASH_SOURCE[0]}
plugin_dir=$(dirname "$(dirname "$current_script_path")")

# shellcheck source=../utils.bash
source "${plugin_dir}/utils.bash"

HELP="
asdf odo settings COMMAND

COMMANDS
   which    -   Shows the path to the file where the current odo stores its settings.
   reset    -   Resets the odo settings to their default values.
                This essentially removes the current settings file,
                so subsequent odo commands can recreate it.
   help     -   Shows this help.
"

reset() {
  local odo_config_path=$(asdf env odo | grep GLOBALODOCONFIG | awk -F '=' '{print $2}')
  if [ -f "$odo_config_path" ]; then
    rm -iv "$odo_config_path"
  else
    echo "file not found: \"$odo_config_path\"" >&2
  fi
}

which() {
  asdf env odo | grep GLOBALODOCONFIG | awk -F '=' '{print $2}'
}

case "$*" in
'reset')
  reset
  ;;

'which')
  which
  ;;

*)
  echo "$HELP"
  exit 0
  ;;
esac
