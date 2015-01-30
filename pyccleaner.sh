#!/bin/bash
# finds and deletes all *.pyc files recursively through the current directory
COUNT=$(find . -name \*.pyc -print -delete | wc -l)
echo "Cleaned out $COUNT .pyc files."
