#!/bin/bash
# aptitude install {libssl,libxml2,libxslt,python,lib32z1,libjpeg}-dev
PY_VER="3.5"
BUILDER_DIR=/home/fenrir/Projects/pbuilder
CPYTHON_DIR=/home/fenrir/Projects/cpython
TAURUS_DIR=/home/fenrir/Projects/taurus
TMP_BUILD_DIR="$BUILDER_DIR"/tmp
PREFIX="$BUILDER_DIR"/python.$PY_VER
VENV_DIR="$BUILDER_DIR"/venv.$PY_VER

if [ -d "$TMP_BUILD_DIR" ]; then
	echo "removing old $TMP_BUILD_DIR..."
	rm -rf "$TMP_BUILD_DIR"
fi

if [ -d "$PREFIX" ]; then
	echo "removing old $PREFIX..."
	rm -rf "$PREFIX"
fi

if [ -d "$VENV_DIR" ]; then
	echo "removing old $VENV_DIR..."
	rm -rf "$VENV_DIR"
fi

echo "creation dirs..."
mkdir "$TMP_BUILD_DIR"
mkdir "$PREFIX"
mkdir "$VENV_DIR"

cd "$TMP_BUILD_DIR"

"$CPYTHON_DIR"/configure --with-pydebug --prefix="$PREFIX"

make && make install

virtualenv "$VENV_DIR" -p "$PREFIX"/bin/python3

