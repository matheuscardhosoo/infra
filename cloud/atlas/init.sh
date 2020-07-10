#!/bin/bash

function show_help() {
cat << EOF
Usage: ${0##*/} [-e <environment>] [-n <string>] [-p <project_name>] [-s <string>]
    -e        the environment name
    -n        the profile name to use
    -p        the project name
    -s        the infrastructure source
EOF
}


ENV="dev"
PROFILE="dev"
PROJECT="$(basename $(pwd))"
SOURCE="infrastructure"


while getopts "e:n:p:s:" optvalue; do
    case $optvalue in
        e) ENV="${OPTARG}" ;;
        n) PROFILE="${OPTARG}" ;;
        p) PROJECT="${OPTARG}" ;;
        s) SOURCE="${OPTARG}" ;;
        \?)
            show_help
            exit 1
            ;;
    esac
done

while getopts "e:" optvalue; do
    case $optvalue in
        e) ENV="${OPTARG}" ;;
        \?)
            show_help
            exit 1
            ;;
    esac
done

source ~/.atlas/credentials/$ENV

echo "# Atlas provider
variable \"atlas_public_api_key\" {}
variable \"atlas_private_api_key\" {}
variable \"atlas_env\" {}

provider \"mongodbatlas\" {
  version     = \"0.6\"
  public_key  = \"var.atlas_public_api_key\"
  private_key = \"var.atlas_private_api_key\"
}
" >> settings.tf

echo "# Atlas variables
atlas_public_api_key  = \"$MONGODB_ATLAS_PUBLIC_KEY\"
atlas_private_api_key = \"$MONGODB_ATLAS_PRIVATE_KEY\"
atlas_env             = \"$ENV\"
atlas_profile         = \"$PROFILE\"
atlas_project         = \"$PROJECT\"
" >>  terraform.tfvars

echo "# Atlas main module
module \"atlas_$PROJECT\" {
  source  = \"./$SOURCE/atlas/\"
  env     = \"var.env\"
  profile = \"var.profile\"
  project = \"var.project\"
}
" >> main.tf

if ([[ ! -f "$SOURCE/atlas/main.tf" ]]); then
mkdir -p $SOURCE/atlas
echo "# Input variables
variable \"atlas_env\" {}
variable \"atlas_profile\" {}
variable \"atlas_project\" {}
" > $SOURCE/atlas/main.tf
fi

echo "

 Atlas Cloud infra for $PROJECT:
   - Environment: $ENV
   - Profile: $PROFILE
"
