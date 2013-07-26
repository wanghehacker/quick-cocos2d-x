#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LUADOCX="$DIR/lib/luadocx/luadocx.php"
ROOT_DIR="`dirname $DIR`"
CONFIG_PATH="$ROOT_DIR/doc/apidoc_config.json"
SOURCE_DIR="$ROOT_DIR/framework"
TEMP_DIR="$ROOT_DIR/tmp/apidoc_src"

if [ ! -d $TEMP_DIR ]; then
    mkdir -p $TEMP_DIR
fi
rm -fr $TEMP_DIR/*

php "$LUADOCX" extract -c "$CONFIG_PATH" "$SOURCE_DIR" "$TEMP_DIR"