# AKS migration guide

## Objective
Migrate AKS node pools from a single-zone design to a multi-zone configuration to increase resilience and reduce workload risk during maintenance or disruption.

## Pre-checks
```bash
az aks nodepool list --resource-group <RG_NAME> --cluster-name <AKS_NAME> -o table
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get svc -A
kubectl get ingress -A
```

## Add the new zone-aware node pool
```bash
az aks nodepool add \
  --resource-group <RG_NAME> \
  --cluster-name <AKS_NAME> \
  --name npzones \
  --node-count 3 \
  --zones 1 2 3 \
  --node-vm-size Standard_DS2_v2
```

## Validate scheduler readiness
```bash
kubectl get nodes -L topology.kubernetes.io/zone
kubectl describe nodes
```

## Drain old nodes safely
```bash
kubectl cordon <old-node-name>
kubectl drain <old-node-name> --ignore-daemonsets --delete-emptydir-data
```

## Monitor workloads
```bash
kubectl get pods -A -o wide --watch
kubectl get events --sort-by=.metadata.creationTimestamp
```

## Delete old node pool
```bash
az aks nodepool delete \
  --resource-group <RG_NAME> \
  --cluster-name <AKS_NAME> \
  --name <OLD_POOL_NAME>
```

## Operational notes
- Always validate service health before deleting the old pool
- Keep a rollback path ready
- Use `PodDisruptionBudget` for critical services
- Prefer phased migration for production workloads
