<div align="center">

# asdf-odo [![Build](https://github.com/rm3l/asdf-odo/actions/workflows/build.yml/badge.svg)](https://github.com/rm3l/asdf-odo/actions/workflows/build.yml) [![Lint](https://github.com/rm3l/asdf-odo/actions/workflows/lint.yml/badge.svg)](https://github.com/rm3l/asdf-odo/actions/workflows/lint.yml)


[odo](https://odo.dev) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [FAQ](#FAQ)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, `shasum`: generic POSIX utilities
- Optionally, `unzip`, `git` and [Golang](https://go.dev/doc/install) if you want to build and install unreleased development branches or specific commits. You may want to install Golang using this other asdf plugin: [asdf-golang](https://github.com/kennyp/asdf-golang)

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

# List all installed versions
asdf list odo

# Set a version globally (on your ~/.tool-versions file)
asdf global odo latest

# Set a version depending on the project directory.
# Note that this creates a file named '.tool-versions' in the current directory.
# You may want to put that file under version control.
asdf local odo latest

# Now odo commands are available
odo version
```

Check [asdf](https://github.com/asdf-vm/asdf) README for more instructions on how to
install & manage versions.

# FAQ

## How do I install specific releases of odo?

You can first list all installable versions (actually, all GitHub releases) with:
```shell
asdf list-all odo
```

Now you can pick and install any version from the list above:
```shell
asdf install odo <version>
```

## How do I install odo from specific (unreleased) Git commits or branches?

NOTE: As this requires building `odo`, the commands below require `unzip`, `git` and [Golang](https://go.dev/doc/install) to be installed. You may want to install Golang using this other plugin for asdf: [asdf-golang](https://github.com/kennyp/asdf-golang)

### Using the upstream repo
```shell
asdf install odo ref:<commit_or_branch>
```

### Using a different fork repo
You need to set the `ASDF_GITHUB_REPO_FOR_ODO` environment variable beforehand:

```shell
ASDF_GITHUB_REPO_FOR_ODO=https://github.com/<org_or_user>/odo asdf install odo ref:<commit_or_branch>
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

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/rm3l/asdf-odo/graphs/contributors)!

# License

See [MIT License](LICENSE) © [Armel Soro](https://github.com/rm3l/)
