#!/bin/bash
STAGED_GO_FILES=$(git diff --cached --name-only | grep "\.go$")

if [[ "$STAGED_GO_FILES" = "" ]]; then
echo "No go files"
  exit 0
fi

PASS=true

for FILE in $STAGED_GO_FILES
do
  # Run govet on the staged file and check the exit status
  #It finds possible bugs and suspicious constructs
  go vet $FILE
  if [[ $? != 0 ]]; then
    printf "\t\033[31mgo vet $FILE\033[0m \033[0;30m\033[41mFAILURE!\033[0m\n"
    PASS=false
  else
    printf "\t\033[32mgo vet $FILE\033[0m \033[0;30m\033[42mpass\033[0m\n"
  fi
done

