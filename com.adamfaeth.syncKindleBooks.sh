#!/bin/bash

user=`whoami`
syncFrom="/Users/${user}/Books/"
syncTo="/Volumes/Kindle/Documents/Books"


mkdir -p "$syncTo"

# use capital-L to copy original files, not symlinks
rsync -aL --include "*/" --include "*.pdf" --include "*.mobi" --exclude "*" --delete "$syncFrom" "$syncTo"
git