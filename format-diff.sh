#!/bin/sh
git diff -U0 --no-color master | clang-format-diff.py -i -p1
