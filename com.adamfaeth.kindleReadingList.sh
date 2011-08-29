#!/bin/bash

user=`whoami`
syncFrom="/Users/${user}/Dropbox/ReadingList/"
syncTo="/Volumes/Kindle/Documents/Reading List"


mkdir -p "$syncTo"

# use capital-L to copy original files, not symlinks
rsync -aL --delete "$syncFrom" "$syncTo"
