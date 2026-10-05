#!/bin/bash

echo "Checking node zones..."
kubectl get nodes -L topology.kubernetes.io/zone

echo "Checking pod health..."
kubectl get pods -A -o wide

