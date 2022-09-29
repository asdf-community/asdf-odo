<div align="center">

# asdf-odo [![Build](https://github.com/rm3l/asdf-odo/actions/workflows/build.yml/badge.svg)](https://github.com/rm3l/asdf-odo/actions/workflows/build.yml) [![Lint](https://github.com/rm3l/asdf-odo/actions/workflows/lint.yml/badge.svg)](https://github.com/rm3l/asdf-odo/actions/workflows/lint.yml)


[asdf](https://asdf-vm.com) plugin for managing runtime versions of [odo](https://odo.dev), the developer-focused CLI for fast & iterative application development on [OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift) and [Kubernetes](https://kubernetes.io/).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Additional commands](#additional-commands)
- [FAQ](#FAQ)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- **Required**: `bash`, `curl`, `shasum`
- **Optional**: `unzip` and [Golang](https://go.dev/doc/install) if you want to install unreleased development branches or specific commits. You may want to install Golang using this other asdf plugin: [asdf-golang](https://github.com/kennyp/asdf-golang) ;)

# Install

You first need to install and configure [asdf](https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies).

After that, you can install this plugin:

```shell
# The command below works because this plugin is referenced
# in the central plugins repository: https://github.com/asdf-vm/asdf-plugins
asdf plugin add odo
```

or using the full repo URL:

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
# You can also run: asdf exec odo [odo_options]
```

Check [asdf](https://github.com/asdf-vm/asdf) README for more instructions on how to
install & manage versions.

# Additional commands

This plugin defines additional `asdf` commands with helpers that extend `odo`.

## Preferences management

This is availabe via the `asdf odo preference` command:

```sh
asdf odo preference COMMAND

COMMANDS
   which    -   Shows the path to the file where the current odo stores its settings.
   reset    -   Resets the odo settings to their default values.
                This essentially removes the current preferences file,
                so subsequent odo commands can recreate it.
   help     -   Shows this help.

```

NOTE:  `odo` already comes bundled with a [`preference` command](https://odo.dev/docs/command-reference/preference), but the additional commands defined here aim at extending it a little bit.

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

NOTE: This will download and build `odo` on your machine. Make sure you installed these optional [dependencies](README.md#dependencies), besides the mandatory ones: `unzip`, `git` and [Golang](https://go.dev/doc/install). You may want to install Golang using this other plugin for `asdf`: [asdf-golang](https://github.com/kennyp/asdf-golang)

### Using the upstream `odo` repo
```shell
asdf install odo ref:<commit_or_branch>
```

### Using a different fork repo on GitHub
You need to set the `ASDF_GITHUB_REPO_FOR_ODO` environment variable beforehand. It can either be a complete GitHub HTTPS URL, or formatted as follows: `<org_or_user>/<repo>`.

```shell
ASDF_GITHUB_REPO_FOR_ODO=<org_or_user>/<repo> \
  asdf install odo ref:<commit_or_branch>
```

Or:

```shell
ASDF_GITHUB_REPO_FOR_ODO=https://github.com/<org_or_user>/<repo> \
  asdf install odo ref:<commit_or_branch>
```

## Can I override the binary architecture?

The following environment variables can be used to override the `odo` binary that will get downloaded by this plugin.
Please refer to the [artifacts listing page](https://developers.redhat.com/content-gateway/rest/mirror/pub/openshift-v4/clients/odo) for more info about the supported platforms and architectures.

- `ASDF_ODO_BINARY_OS_ARCH`. Defines both the operating system and architecture for the binary. Must follow this pattern: `<platform>-<architecture>`. Examples: `darwin-amd64`, `linux-s390x`
- `ASDF_ODO_BINARY_OS`. Defines the operating system for the binary. In this case, the plugin will attempt to determine the right architecture. Examples: `darwin`, `windows`, `linux`
- `ASDF_ODO_BINARY_ARCH`. Defines the architecture for the binary. In this case, the plugin will attempt to determine the right operating system. Examples: `arm64`, `s390x`, `amd64`, ...

Note that, if defined, `ASDF_ODO_BINARY_OS_ARCH` always take precedence over the other two environment variables.

Examples:

```shell
# ASDF_ODO_BINARY_OS_ARCH allows to override both the operation system and architecture to use
ASDF_ODO_BINARY_OS_ARCH=darwin-amd64 asdf install odo latest
```

or

```shell
# The architecture will be determined automatically
ASDF_ODO_BINARY_OS=windows asdf install odo latest
```

or

```shell
# The operating system will be determined automatically
ASDF_ODO_BINARY_ARCH=arm64 asdf install odo latest
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
Because of the way `asdf` works (by enforcing exact versions), if you installed odo from a development branch and wish to update it, you need to reinstall that specific version.
To reinstall an already installed version of odo, first [uninstall it](README.md#how-do-i-uninstall-a-given-version-of-odo), and then [install it](README.md#install) again.

`latest` is a special version number that `asdf` dynamically resolves to the latest known version at the time of execution. So running `asdf install odo latest` might install a newer version of `odo`, if a newer version is available at the time the command is executed.

## Can I use this plugin on Windows?
Not officially supported :)

`asdf` itself does not support Windows officially, per [their FAQ](http://asdf-vm.com/learn-more/faq.html#faq).
Running it on [Windows Subsystem for Linux (WSL) 2](https://docs.microsoft.com/en-us/windows/wsl/about) should work however, as written in [this blog](https://www.joshfinnie.com/blog/setting_up_wsl_with_asdf/). But this is not tested/supported.

So if you already have `asdf` running on `WSL 2`, you should be able to use this plugin as well.

## How do I know what this plugin really does?

Set the `ASDF_ODO_VERBOSE` environment variable to `true` prior to running this plugin,
and you will be able to get more detailed information. For example:

```shell
ASDF_ODO_VERBOSE=true asdf install odo 3.0.0
```

# Contributing

Contributions of any kind are welcome! See the [contributing guide](contributing.md).

[Thanks to these contributors](https://github.com/rm3l/asdf-odo/graphs/contributors)!

# License

See [MIT License](LICENSE) © [Armel Soro](https://github.com/rm3l/)
