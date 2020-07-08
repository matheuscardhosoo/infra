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

source ~/.atlas/credentials/$ENV

echo "
variable \"atlas_public_api_key\" {}
variable \"atlas_private_api_key\" {}
variable \"atlas_env\" {}

provider \"mongodbatlas\" {
  version      = \"0.6\"
  public_key   = \"var.mongodbatlas_public_key\"
  private_key  = \"var.mongodbatlas_private_key\"
}" > settings.tf

echo "
atlas_public_api_key = \"$MONGODB_ATLAS_PUBLIC_KEY\"
atlas_private_api_key = \"$MONGODB_ATLAS_PRIVATE_KEY\"
atlas_env = \"$ENV\"" >  terraform.tfvars

echo Atlas env: $ENV