#!/usr/bin/env bash
set -e

# https://developer.hashicorp.com/vagrant/vagrant-cloud/api/v2

VAGRANT_TOKEN=${VAGRANT_TOKEN:-""}
VAGRANT_USER=${VAGRANT_USER:-"ssplatt"}
BOX_NAME=${BOX_NAME:-"centos-stream-9"}
VERSION=${VERSION:-"0.0.1"}
BOX_PATH=${BOX_PATH:-"output/package.box"}
PROVIDER=${PROVIDER:-"virtualbox"}
ARCH=${ARCH:-"amd64"}

# Create a new version
curl \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${VAGRANT_TOKEN}" \
  "https://app.vagrantup.com/api/v2/box/${VAGRANT_USER}/${BOX_NAME}/versions" \
  --data "{ \"version\": { \"version\": \"${VERSION}\" } }"

# Create a new provider
curl \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer ${VAGRANT_TOKEN}" \
  "https://app.vagrantup.com/api/v2/box/${VAGRANT_USER}/${BOX_NAME}/version/${VERSION}/providers" \
  --data "{ \"provider\": { \"name\": \"${PROVIDER}\",
            \"architecture\": \"${ARCH}\",
            \"default_architecture\": true} }"

# Prepare the provider for upload/get an upload URL
response=$(curl \
    --request GET \
    --header "Authorization: Bearer ${VAGRANT_TOKEN}" \
    "https://app.vagrantup.com/api/v2/box/${VAGRANT_USER}/${BOX_NAME}/version/${VERSION}/provider/${PROVIDER}/${ARCH}/upload")

# Extract the upload URL from the response (requires the jq command)
upload_path=$(echo "$response" | jq -r .upload_path)

# Perform the upload
curl \
    --request PUT \
    --upload-file "${BOX_PATH}" \
    "$upload_path"

# Release the version
curl \
  --request PUT \
  --header "Authorization: Bearer ${VAGRANT_TOKEN}" \
  "https://app.vagrantup.com/api/v2/box/${VAGRANT_USER}/${BOX_NAME}/version/${VERSION}/release"
