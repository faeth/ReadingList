#!/bin/bash

# (The MIT License)
# 
# Copyright (c) 2011 Adam Faeth
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# If this script runs from launchd, it may run as a different user
user=`whoami`
syncTo="/Users/${user}/Dropbox/ReadingList"
tmpFolder="/tmp/com.adamfaeth.readinglist/"

# Paths to papers libraries
library="/Users/${user}/Documents"
papers2="Papers2"
p2Lib="$library/$papers2/Library.papers2/Database.papersdb"

# Get flagged papers from the databases
p2Query="SELECT PDF.path FROM Publication INNER JOIN PDF on PDF.object_id=Publication.rowid  where Publication.flagged > 0;"

# fetch flagged papers and prepend absolute paths
if [ -f "$p2Lib" ] 
then
    listTwo=$(sqlite3 -list "$p2Lib" "$p2Query" )
    if [ "$listTwo" ]
    then
    	listTwo=$(echo "$listTwo" | while read line; do echo "$papers2/$line"; done)
    fi
fi

# create a temp dir of symlinks so rysnc will delete items that were removed
mkdir -p "$tmpFolder"
mkdir -p "$syncTo"

echo "$listTwo" | while read pdf
do
    if [ "$pdf" ]
        then
        # ${##*/} is a glob that matches the filename and extension in a path
        ln -sf "$library/$pdf" "$tmpFolder/${pdf##*/}"
    fi
done

# use -l to copy the link and -L to copy original linked file
rsync -al --delete "$tmpFolder" "$syncTo"

rm -rf "$tmpFolder"