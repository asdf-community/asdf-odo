<div align="center">

# asdf-odo [![Build](https://github.com/rm3l/asdf-odo/actions/workflows/build.yml/badge.svg)](https://github.com/rm3l/asdf-odo/actions/workflows/build.yml) [![Lint](https://github.com/rm3l/asdf-odo/actions/workflows/lint.yml/badge.svg)](https://github.com/rm3l/asdf-odo/actions/workflows/lint.yml)


[asdf](https://asdf-vm.com) plugin for managing runtime versions of [odo](https://odo.dev), the developer-focused CLI for [OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift) and [Kubernetes](https://kubernetes.io/).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [FAQ](#FAQ)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- **Required**: `bash`, `curl`, `shasum`, `git`
- **Optional**: `unzip` and [Golang](https://go.dev/doc/install) if you want to install unreleased development branches or specific commits. You may want to install Golang using this other asdf plugin: [asdf-golang](https://github.com/kennyp/asdf-golang) ;)

# Install

You first need to install and configure [asdf](https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies).

After that, you can install this plugin:

```shell
asdf plugin add odo https://github.com/rm3l/asdf-odo.git
```

To check that the plugin is installed correctly and to manage versions of `odo`:

```shell
# Show all installable versions
asdf list-all odo

# Install latest version
asdf install odo latest

# Set a version globally (on your ~/.tool-versions file)
asdf global odo latest

# Set a version depending on the project directory.
# Note that this creates a file named '.tool-versions' in the current directory.
# You may want to put that file under version control.
asdf local odo <version>

# Now odo commands are available
odo version
odo help
```

Check [asdf](https://github.com/asdf-vm/asdf) README for more instructions on how to
install & manage versions.

# FAQ

## How do I install specific releases of odo?

You can first list all installable versions (actually, all Git tags from the [upstream repository](https://github.com/redhat-developer/odo)) with:
```shell
asdf list-all odo
```

Now you can pick and install any version from the list above:
```shell
asdf install odo <version>
```

## How do I install odo from specific (unreleased) Git commits or branches?

NOTE: This requires downloading and building `odo`. Make sure you installed these optional [dependencies](README.md#dependencies), besides the mandatory ones: `unzip` and [Golang](https://go.dev/doc/install). You may want to install Golang using this other plugin for asdf: [asdf-golang](https://github.com/kennyp/asdf-golang)

### Using the upstream GitHub repo
```shell
asdf install odo ref:<commit_or_branch>
```

### Using a different fork repo on GitHub
You need to set the `ASDF_GITHUB_REPO_FOR_ODO` environment variable beforehand. It can either be a complete GitHub HTTPS URL, or formatted as follows: `<org_or_user>/<repo>`.

```shell
ASDF_GITHUB_REPO_FOR_ODO=<org_or_user>/<repo> asdf install odo ref:<commit_or_branch>
```

Or:

```shell
ASDF_GITHUB_REPO_FOR_ODO=https://github.com/<org_or_user>/<repo> asdf install odo ref:<commit_or_branch>
```

## How do I uninstall a given version of odo?

First of all, you can list all installed versions of `odo`, like so:
```shell
asdf list odo
```

You can now uninstall any version listed above, like so:
```shell
asdf uninstall odo <version>
```

## How do I reinstall an already installed version of odo?
Because of the way asdf works, if you installed odo from a development branch and wish to update it, you need to reinstall that specific version.
To reinstall an already installed version of odo, first [uninstall it](README.md#how-do-i-uninstall-a-given-version-of-odo), and then [install it](README.md#install) again.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks to these contributors](https://github.com/rm3l/asdf-odo/graphs/contributors)!

# License

See [MIT License](LICENSE) © [Armel Soro](https://github.com/rm3l/)
