#!/bin/bash

# Copied from https://gist.github.com/pnc/b7fb38d70f157cd40595d9e52bebc055
# and https://twitter.com/pnc/status/974842087798640641?s=09

# prereq:  brew install tesseract xmlstarlet imagemagick

set -e

echo "Checking $1"
# CONTENTS=$(tesseract -c language_model_penalty_non_dict_word=0.8 --tessdata-dir /usr/local/share/ "$1" stdout -l eng | xml esc)
CONTENTS=$(convert "$1" -magnify -alpha remove - | tesseract -c language_model_penalty_non_dict_word=0.8 --tessdata-dir /usr/local/share/ stdin stdout -l eng | xml esc)

hex=$((cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<string>$CONTENTS</string>
</plist>
EOF
) | plutil -convert binary1 - -o - | xxd -p | tr -d '\n')
xattr -w -x com.apple.metadata:kMDItemFinderComment "$hex" "$1"
mdimport "$1"
