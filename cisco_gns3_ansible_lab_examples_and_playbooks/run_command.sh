#!/usr/bin/env bash
set -euo pipefail

read -rp "Enter Ansible host or group (e.g., vios, sw1): " TARGET_HOST
if [[ -z "${TARGET_HOST}" ]]; then
  echo "Error: host or group cannot be empty." >&2
  exit 1
fi

read -rp "Enter Cisco show or configuration command: " DEVICE_COMMAND
if [[ -z "${DEVICE_COMMAND}" ]]; then
  echo "Error: command cannot be empty." >&2
  exit 1
fi

ANSIBLE_STDOUT_CALLBACK=${ANSIBLE_STDOUT_CALLBACK:-default} \
ansible -i inventory.ini "${TARGET_HOST}" \
  -m cisco.ios.ios_command \
  -a "commands=${DEVICE_COMMAND@Q}" "$@"
