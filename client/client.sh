#!/bin/bash -vexu

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

curl --cacert "${SCRIPT_DIR}"/../ca/CA.pem https://localhost:8080
