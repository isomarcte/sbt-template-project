#!/usr/bin/env bash

set -ex

function main {
    if [ -z "${SCM_URL}" ]
    then
        declare -xr SCM_URL='https://github.com/isomarcte/sbt-template-project.git'
    fi

    declare TEMP_CLONE
    TEMP_CLONE="$(mktemp -d)"
    readonly TEMP_CLONE
    trap 'rm -rf ${TEMP_CLONE}' ERR
    pushd "$TEMP_CLONE"

    git clone -- "${SCM_URL:?}" temp

    pushd temp

    if [ -n "$REF_NAME" ]
    then
        git checkout "${REF_NAME}"
    fi

    popd

    popd

    mv -v "${TEMP_CLONE:?}/temp/template" "${TARGET_DIR:?}"

    rm -rf "${TEMP_CLONE:?}"

    pushd "${TARGET_DIR:?}"

    git init

    popd
}

main "$@"
