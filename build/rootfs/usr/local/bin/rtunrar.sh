#!/bin/sh

if [ -d $1 ]; then
  find $1 -name '*.rar' -execdir 7z x {} \;
fi
