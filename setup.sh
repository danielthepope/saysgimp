#!/usr/bin/env bash
command -v gimp >/dev/null 2>&1 || { echo >&2 "Command 'gimp' not found. Please install before continuing."; exit 1; }
set -e
cd `dirname $0`
cp says-gimp.scm "$HOME/.gimp-2.8/scripts/"
bundle install
echo 'Setup successful'
