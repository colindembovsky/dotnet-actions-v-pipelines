#!/bin/bash
set -euxo pipefail

rg=$1
aci_name=$2
image=$3

az group create -n $rg -l southcentralus
az container create -g $rg --name $aci_name --image $image
