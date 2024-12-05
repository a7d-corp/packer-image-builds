#!/usr/bin/env bash

BASE_DIR=$(git rev-parse --show-toplevel)
DEPLOY_DIR=$(echo "${BASE_DIR}/deploy")

# read in host vars
VMIDS=$(cat "${DEPLOY_DIR}/template_ids.json")

jq -n "$VMIDS" | \
    jq -c --arg distro "$DISTRO" --arg release "$RELEASE" '.[$distro][$release][]' | \
    while read template ; do
        # extract variables
        _host=$(echo "$template" | jq -r .host)
        _id=$(echo "$template" | jq -r .id)

        echo -e "===> Ensuring stopped: ${DISTRO}/${RELEASE} template ${_id} on ${_host}\n"
        
        curl -s -X POST -H "Authorization: PVEAPIToken=${PVE_API_TOKEN}" \
            "${PVE_API_URL}/api2/json/nodes/${_host}/qemu/${_id}/status/stop"
        until $(curl -s -H "Authorization: PVEAPIToken=${PVE_API_TOKEN}" \
                "${PVE_API_URL}/api2/json/nodes/${_node}/qemu/${_id}/status/current" | \
                jq -r .data.status | grep -qiE "stopped|null"); do
                    echo -e "\n===> Waiting for stopped status: ${DISTRO}/${RELEASE} template ${_id}} on ${_host}\n"
                    sleep 5
        done
  
        echo -e "\n===> Deleting: ${DISTRO}/${RELEASE} template ${_id} on ${_host}\n"
        curl -s -X DELETE -H "Authorization: PVEAPIToken=${PVE_API_TOKEN}" \
            "${PVE_API_URL}/api2/json/nodes/${_host}/qemu/${_id}"
        echo -e "\n"
done