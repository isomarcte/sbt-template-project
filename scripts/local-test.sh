#!/usr/bin/bash

declare -rx PROJECT_NAME='local-test'
declare -rx PROJECT_ORG='io.isomarcte'
declare -rx NOT_CI='true'

function main {
    ./test.sh
}

main "$@"
