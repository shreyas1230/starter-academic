#!/usr/bin/env bash

while getopts ":m:" opt; do
  case $opt in
    m)
      git add .
      git commit -m "$OPTARG"
      git push -u origin master

      hugo
      cd public
      git add .
      git commit -m "Build website"
      git push origin main
      cd ..
      ;;
    \?)
      echo "Requires -m flag. Invalid flag: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Provide a commit message after -$OPTARG." >&2
      exit 1
      ;;
  esac
done

if [ $# -eq 0 ]; then
    echo "Requires -m flag and a commit message." >&2
    exit 1
fi

echo "Done pushing to git." >&2
