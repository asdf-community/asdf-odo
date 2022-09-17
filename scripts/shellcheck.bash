#!/usr/bin/env bash

# MIT License

exec shellcheck -s bash -x \
  bin/* -P lib/
