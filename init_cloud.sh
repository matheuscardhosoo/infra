#!/bin/bash

function show_help() {
cat << EOF
Usage: ${0##*/} [-e <environment>] [-n <string>] [-p <project_name>] [-m] [-a]
    -e        the environment name
    -n        the profile name to use
    -p        the project name
    -m        the atlas mongodb service provider
    -a        the aws service provider
EOF
}

ENV="dev"
PROFILE="dev"
PROJECT="$(basename $(pwd))"
ATLAS=""
AWS=""

while getopts "e:n:p:ma" optvalue; do
    case $optvalue in
        e) ENV="${OPTARG}" ;;
        n) PROFILE="${OPTARG}" ;;
        p) PROJECT="${OPTARG}" ;;
        m) ATLAS="-m" ;;
        a) AWS="-a" ;;
        \?)
            show_help
            exit 1
            ;;
    esac
done

./infra/cloud/init.sh -e "$ENV" -n "$PROFILE" -p "$PROJECT" $ATLAS $AWS
