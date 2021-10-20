#!/bin/bash
set -euxo pipefail

rg=$1
aci_name=$2
image=$3

az group create -n $rg -l southcentralus
az container create -g $rg --name $aci_name --image $image --dns-name-label $aci_name

fqdn=$(az container show -n $aci_name -g $rg --query "ipAddress.fqdn" -o tsv)
echo "::set-output name=fqdn::$fqdn"
