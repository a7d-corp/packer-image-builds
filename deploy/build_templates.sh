#!/usr/bin/env bash

BASE_DIR=$(git rev-parse --show-toplevel)
DEPLOY_DIR=$(echo "${BASE_DIR}/deploy")

WORKDIR=$(echo "${BASE_DIR}/${DISTRO}/${RELEASE}")

# read in host vars
VMIDS=$(cat "${DEPLOY_DIR}/template_ids.json")

cd "${WORKDIR}"

jq -n "$VMIDS" | \
    jq -c --arg distro "$DISTRO" --arg release "$RELEASE" '.[$distro][$release][]' | \
    while read template ; do
        # extract variables
        _host=$(echo "$template" | jq -r .host)
        _id=$(echo "$template" | jq -r .id)

        echo -e "\n===> Building ${DISTRO}/${RELEASE} on ${_host}\n"
        packer build -on-error=abort \
            -var proxmox_node="${_host}" \
            -var vm_id="${_id}" .
done