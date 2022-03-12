<div align="center">

# asdf-odo [![Build](https://github.com/rm3l/asdf-odo/actions/workflows/build.yml/badge.svg)](https://github.com/rm3l/asdf-odo/actions/workflows/build.yml) [![Lint](https://github.com/rm3l/asdf-odo/actions/workflows/lint.yml/badge.svg)](https://github.com/rm3l/asdf-odo/actions/workflows/lint.yml)


[odo](https://odo.dev) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add odo https://github.com/rm3l/asdf-odo.git
```

odo:

```shell
# Show all installable versions
asdf list-all odo

# Install specific version
asdf install odo latest

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
