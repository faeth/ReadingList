#!/bin/bash

# If this script runs from launchd, it may run as a different user
user=`whoami`
syncTo="/Users/${user}/Dropbox/ReadingList"
tmpFolder="/tmp/com.adamfaeth.readinglist/"

# Paths to papers libraries
library="/Users/${user}/Documents"
papers1="Papers"
p1Lib="$library/$papers1/Library.papers"

# Get flagged papers from the databases
p1Query="Select ZPATH FROM ZPAPER WHERE ZFLAGGED > 0;"

# fetch flagged papers and prepend absolute paths
if [ -f "$p1Lib" ] 
then
    listOne=$(sqlite3 -list "$p1Lib" "$p1Query" )
    if [ "$listOne" ]
    then
    	listOne=$(echo "$listOne" | while read line; do echo "$papers1/$line"; done)
    fi
fi

# create a temp dir of symlinks so rysnc will delete items that were removed
mkdir -p "$tmpFolder"
mkdir -p "$syncTo"

echo "$listOne" | while read pdf
do
    if [ "$pdf" ]
        then
        # ${##*/} is a glob that matches the filename and extension in a path
        ln -sf "$library/$pdf" "$tmpFolder${pdf##*/}"
    fi
done

# use -l to copy the link and -L to copy original linked file
rsync -al --delete "$tmpFolder" "$syncTo"

rm -rf "$tmpFolder"