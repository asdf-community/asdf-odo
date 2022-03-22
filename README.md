<div align="center">

# asdf-odo [![Build](https://github.com/rm3l/asdf-odo/actions/workflows/build.yml/badge.svg)](https://github.com/rm3l/asdf-odo/actions/workflows/build.yml) [![Lint](https://github.com/rm3l/asdf-odo/actions/workflows/lint.yml/badge.svg)](https://github.com/rm3l/asdf-odo/actions/workflows/lint.yml)


[odo](https://odo.dev) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, `shasum`: generic POSIX utilities
- Optionally, `git` and [Golang](https://go.dev/doc/install) if you want to build and install unreleased development branches or specific commits. Note you can install Golang with this other asdf plugin: [asdf-golang](https://github.com/kennyp/asdf-golang)

# Install

Plugin:

```shell
asdf plugin add odo https://github.com/rm3l/asdf-odo.git
```

odo:

```shell
# Show all installable versions
asdf list-all odo

# Install latest version
asdf install odo latest
# You can also install specific versions, e.g.:
# > asdf install odo 2.5.0
# You can even install specific refs (commits or branches)from the upstream repo
# > asdf install odo ref:main
# TODO Allow to install specific refs (commits or branches) from forks, like so:
# > asdf install odo ref:<remote_url>#<ref>

# Set a version globally (on your ~/.tool-versions file)
asdf global odo latest

# Now odo commands are available
odo version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/rm3l/asdf-odo/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Armel Soro](https://github.com/rm3l/)
