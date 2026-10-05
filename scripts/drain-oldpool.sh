#!/bin/bash

OLD_POOL_NAME="${OLD_POOL_NAME:-<OLD_POOL_NAME>}"

nodes=$(kubectl get nodes -l agentpool="$OLD_POOL_NAME" -o name)

for node in $nodes; do
  echo "Cordon and drain: $node"
  kubectl cordon "$node"
  kubectl drain "$node" --ignore-daemonsets --delete-emptydir-data --force
  echo "---"
done
