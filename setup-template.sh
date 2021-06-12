#!/usr/bin/env bash

set -e

function set_project_org {
    if [ -z "${PROJECT_ORG}" ]
    then
        declare PROJECT_ORG
        read -r -p 'Project Organization: ' PROJECT_ORG
        export PROJECT_ORG
    fi

    readonly PROJECT_ORG

    sed -i "s/<PROJECT_ORG>/${PROJECT_ORG}" ./build.sbt
}

function main {
    pushd "${TARGET_DIR:?}"

    set_project_org

    popd
}

main "$@"
