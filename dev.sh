#!/usr/bin/env bash

_DIR=$(cd "$(dirname "$0")"; pwd)
cd $_DIR

coffee --watch --compile gitsrc.coffee

