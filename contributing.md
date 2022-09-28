# Contributing

Testing locally:

```shell
asdf plugin test <plugin-name> <plugin-url> \
    [--asdf-tool-version <version>] \
    [--asdf-plugin-gitref <git-ref>] \
    [test-command*]
```

Example:

```shell
asdf plugin test odo https://github.com/rm3l/asdf-odo.git "odo version"
```

Note that tests are automatically run in GitHub Actions on push (to the `main` branch) and Pull Requests.
