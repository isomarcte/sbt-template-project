#!/usr/bin/env bash

set -e

function setup_scm_url {
    if [ -z "${SCM_URL}" ]
    then
        declare -xr SCM_URL='https://github.com/isomarcte/sbt-template-project.git'
    fi

}

function ungit {
    rm -rf .git
    rm -rf scripts/
}

function main {
    setup_scm_url

    git clone -- "${SCM_URL:?}" "${TARGET_DIR:?}"

    pushd "${TARGET_DIR:?}"

    if [ -n "$REF_NAME" ]
    then
        git checkout "${REF_NAME}"
    fi

    ungit

    popd
}

main "$@"
