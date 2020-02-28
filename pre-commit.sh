#!/bin/bash

STAGED_GO_FILES=$(git diff --cached --name-only | grep "\.go$")

if [[ "$STAGED_GO_FILES" = "" ]]; then
echo "No go files"
  exit 0
fi

GOLANGCI_LINT=$GOPATH/bin/golangci-lint
GOIMPORTS=$GOPATH/bin/goimports

# Check for golangci-lint
# It scans for style mistakes
if [[ ! -x "$GOLANGCI_LINT" ]]; then
  printf "\t\033[41mPlease install golangci-lint\033[0m (https://github.com/golangci/golangci-lint)"
  exit 1
fi

# Check for goimports
# It check format and imports
if [[ ! -x "$GOIMPORTS" ]]; then
  printf "\t\033[41mPlease install goimports\033[0m (go get golang.org/x/tools/cmd/goimports)"
  exit 1
fi

PASS=true

for FILE in $STAGED_GO_FILES
do
  # Run goimports on the staged file
  $GOIMPORTS -w $FILE

  # Run golangci-lint on the staged file and check the exit status
  #$GOLANGCI_LINT "-set_exit_status" $FILE
  golangci-lint run $FILE

  if [[ $? == 1 ]]; then
    printf "\t\033[31mgolint $FILE\033[0m \033[0;30m\033[41mFAILURE!\033[0m\n"
    PASS=false
  else
    printf "\t\033[32mgolint $FILE\033[0m \033[0;30m\033[42mpass\033[0m\n"
  fi

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

if ! $PASS; then
  printf "\033[0;30m\033[41mCOMMIT FAILED\033[0m\n"
  exit 1
else
  printf "\033[0;30m\033[42mCOMMIT SUCCEEDED\033[0m\n"
fi

exit 0
