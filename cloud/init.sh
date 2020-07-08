#!/bin/bash

function show_help() {
cat << EOF
Usage: ${0##*/} [-a <string>] [-e <environment>] [-n <project_name>] [-r] [-i]
    -e        the environment name
    -p        the project name
EOF
}

ENV="dev"
PROJECT="$(basename $(pwd))"

while getopts "e:p" optvalue; do
    case $optvalue in
        e) ENV="${OPTARG}" ;;
        p) PROJECT="${OPTARG}" ;;
        \?)
            show_help
            exit 1
            ;;
    esac
done

rm -f {settings.tf,terraform.tfvars}

./atlas/init.sh

./terraform init
