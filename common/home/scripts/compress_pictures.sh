#!/bin/bash

IMAGES_DIR="$1"

[ -d "${IMAGES_DIR}" ] && cd "${IMAGES_DIR}" || {
    echo "${IMAGES_DIR} not found"
    exit 1
}

process_file() {
    file="$1"
    exiv2 rm "$file"
    convert -resize '1920x1920>' "$file" "${file%.*}.webp" && cwebp -quiet -q 50 "${file%.*}.webp" && rm -f "$file"
}

export -f process_file

#~/.cargo/bin/deduplicator "${IMAGES_DIR}"
find "${IMAGES_DIR}" -type f \( -iname '*.jpeg' -o -iname '*.jpg' -o -iname '*.png' \) -print0 | parallel -0 process_file
