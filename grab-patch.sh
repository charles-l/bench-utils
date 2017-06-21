#!/bin/mksh
echo "REMINDER: make sure to run format-diff.sh before submitting patch"
git format-patch -U999999 --stdout master | xclip -selection clipboard -i
