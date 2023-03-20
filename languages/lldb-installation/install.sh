#!/usr/bin/env bash
set -euxo pipefail

# Next generation, high-performance debugger
sudo pacman -S lldb
VSCODE_ROOT_DIR=$HOME/.vscode/extensions/llvm-org.lldb-vscode-0.1.0
PACKAGE_JSON_URL=https://github.com/llvm/llvm-project/tree/main/lldb/tools/lldb-vscode/package.json
curl $PACKAGE_JSON_URL --output $VSCODE_ROOT_DIR/package.json

# VSCODE_BIN_DIR=$VSCODE_ROOT_DIR/bin
# mkdir -p $VSCODE_BIN_DIR
