#!/bin/bash
# finds and deletes all *.pyc files recursively through the current directory
USEDIR=${1-.}
COUNT=$(find $USEDIR -name \*.pyc -print -delete | wc -l)
echo "Cleaned out $COUNT .pyc files."
