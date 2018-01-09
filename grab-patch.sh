#!/bin/mksh
echo "REMINDER: make sure to add tests and run format-diff.sh before submitting patch"
git diff master -U999999 | xclip -selection clipboard -i
