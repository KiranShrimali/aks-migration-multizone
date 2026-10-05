#!/bin/bash

RESOURCE_GROUP="${RESOURCE_GROUP:-<RG_NAME>}"
CLUSTER_NAME="${CLUSTER_NAME:-<AKS_NAME>}"
POOL_NAME="${POOL_NAME:-npzones}"
NODE_COUNT="${NODE_COUNT:-3}"
NODE_SIZE="${NODE_SIZE:-Standard_DS2_v2}"

az aks nodepool add \
  --resource-group "$RESOURCE_GROUP" \
  --cluster-name "$CLUSTER_NAME" \
  --name "$POOL_NAME" \
  --node-count "$NODE_COUNT" \
  --zones 1 2 3 \
  --node-vm-size "$NODE_SIZE"
