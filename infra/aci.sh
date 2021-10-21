#!/bin/bash
set -euxo pipefail

rg=$1
aci_name=$2
image=$3
secret=$4

az group create -n $rg -l southcentralus
az container create -g $rg --name $aci_name --image $image --dns-name-label $aci_name --environment-variables secrets__environment=$secret

fqdn=$(az container show -n $aci_name -g $rg --query "ipAddress.fqdn" -o tsv)

# output for Actions
echo "::set-output name=fqdn::http://$fqdn"

# output for Pipelines
echo "##vso[task.setvariable variable=fqdn;]$fqdn"