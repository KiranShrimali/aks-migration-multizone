#!/bin/bash

RESOURCE_GROUP="${RESOURCE_GROUP:-<RG_NAME>}"
CLUSTER_NAME="${CLUSTER_NAME:-<AKS_NAME>}"
OLD_POOL_NAME="${OLD_POOL_NAME:-<OLD_POOL_NAME>}"

az aks nodepool delete \
  --resource-group "$RESOURCE_GROUP" \
  --cluster-name "$CLUSTER_NAME" \
  --name "$OLD_POOL_NAME"
