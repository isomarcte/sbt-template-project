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

    sed -i "s/<PROJECT_ORG>/${PROJECT_ORG}/" ./build.sbt
}

function set_project_name {
    if [ -z "${PROJECT_NAME}" ]
    then
        declare PROJECT_NAME
        read -r -p 'Project Name: ' PROJECT_NAME
        export PROJECT_NAME
    fi

    readonly PROJECT_NAME

    sed -i "s/<PROJECT_NAME>/${PROJECT_NAME}/" ./build.sbt
}

function main {
    pushd "${TARGET_DIR:?}"

    set_project_org
    set_project_name

    popd
}

main "$@"
