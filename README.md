# Kiran Shrimali

<div align="center">

![Azure](https://img.shields.io/badge/Azure-AKS-0078D4?logo=microsoftazure&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Cluster-326CE5?logo=kubernetes&logoColor=white)
![DevOps](https://img.shields.io/badge/DevOps-Automation-4CAF50)
![Cloud](https://img.shields.io/badge/Cloud-Resilience-FF9800)

</div>

Cloud Engineer focused on Azure, Kubernetes, and resilient infrastructure modernization. I build and improve cloud-native systems with an emphasis on high availability, automation, migration safety, and production-ready operations.

## Contact
- LinkedIn: https://www.linkedin.com/in/kiranshrimali2023
- Email: jkshri2010@gmail.com
- GitHub: https://github.com/KiranShrimali

## Featured project
# AKS Node Pool Migration to Multi-Zone Resilience

A production-focused Azure Kubernetes Service migration project demonstrating how to move workloads from a single-zone AKS node pool to a multi-zone, resilient architecture while minimizing risk and preserving service stability.

## Overview
This project documents a safe migration approach for AKS workloads, focusing on:

- multi-zone node pool creation
- workload validation and scheduling
- drain and migration controls
- backup and rollback procedures
- risk mitigation and operational monitoring

This repository is intended to showcase cloud-native engineering, Azure operations, and Kubernetes best practices in a portfolio-ready format.

## Why this matters
Running production workloads in a single AKS availability zone introduces operational risk when a zone becomes unavailable or maintenance events impact the node pool. Moving to a multi-zone design improves:

- availability
- failure isolation
- resilience during cluster changes
- production readiness

## Key skills demonstrated
- Azure Kubernetes Service (AKS)
- Azure CLI administration
- Kubernetes troubleshooting and validation
- Node pool migration planning
- YAML manifest management
- Risk and rollback planning
- DevOps-style documentation and repo presentation

## High-level migration flow
1. Validate current AKS node pool and cluster state
2. Add a new multi-zone node pool
3. Verify new nodes are healthy and schedulable
4. Drain the old node pool carefully
5. Monitor workload recovery and service health
6. Delete the old node pool only after validation

## Commands
### Check current configuration
```bash
az aks nodepool list --resource-group <RG_NAME> --cluster-name <AKS_NAME> -o table
az aks show --resource-group <RG_NAME> --name <AKS_NAME> -o table
kubectl get nodes -o wide
kubectl get pods -A -o wide
```

### Add new multi-zone node pool
```bash
az aks nodepool add \
  --resource-group <RG_NAME> \
  --cluster-name <AKS_NAME> \
  --name npzones \
  --node-count 3 \
  --zones 1 2 3 \
  --node-vm-size Standard_DS2_v2
```

### Validate zone placement
```bash
kubectl get nodes -L topology.kubernetes.io/zone
kubectl get pods -A -o wide
```

### Drain the old pool gradually
```bash
kubectl cordon <old-node-name>
kubectl drain <old-node-name> --ignore-daemonsets --delete-emptydir-data
```

### Delete old pool after validation
```bash
az aks nodepool delete \
  --resource-group <RG_NAME> \
  --cluster-name <AKS_NAME> \
  --name <OLD_POOL_NAME>
```

## Risk mitigation checklist
| Risk | Mitigation |
|---|---|
| Workload outage during migration | Add new multi-zone pool before draining old pool |
| Application downtime during drain | Validate replicas, endurance, and services before workload move |
| Ingress disruption | Validate service readiness before deleting old nodes |
| Data loss on stateful workloads | Confirm persistence and storage dependencies |
| Failed rollback | Export YAML manifests and maintain restore scripts |
| Capacity imbalance | Use proper VM sizing and multi-zone scheduling |

## Backup and rollback plan
```bash
mkdir -p backup
kubectl get ns -o yaml > backup/namespaces.yml
for ns in $(kubectl get ns -o jsonpath='{.items[*].metadata.name}'); do
  mkdir -p backup/$ns
  kubectl get all -n $ns -o yaml > backup/$ns/all.yml
done
kubectl get configmap -A -o yaml > backup/configmaps.yml
kubectl get secret -A -o yaml > backup/secrets.yml
```

Rollback example:
```bash
kubectl uncordon <old-node-name>
kubectl apply -f backup/<namespace>/all.yml
```

## Repository structure
```text
aks-migration-multizone/
├── README.md
├── docs/
│   ├── migration-guide.md
│   ├── risk-mitigation.md
│   └── rollback-plan.md
├── scripts/
│   ├── add-nodepool.sh
│   ├── drain-oldpool.sh
│   ├── delete-oldpool.sh
│   └── verify-zones.sh
├── manifests/
│   └── pdb/
│       └── critical-app-pdb.yaml
├── backup/
├── .github/
│   └── workflows/
│       └── validate.yml
└── images/
```

## Project documentation
- [Migration guide](docs/migration-guide.md)
- [Risk mitigation](docs/risk-mitigation.md)
- [Rollback plan](docs/rollback-plan.md)

## Profile summary
```md
Cloud Engineer | Azure | AKS | Kubernetes | Infrastructure Automation

I design and modernize cloud-native infrastructure with a focus on resilience, high availability, production-safe deployment practices, and operational readiness.

Featured project:
AKS Node Pool Migration to Multi-Zone Resilience

This project demonstrates safe AKS node pool migration, workload orchestration, backup planning, rollback strategies, and operational risk mitigation.
```

## Skills
- Azure Kubernetes Service (AKS)
- Kubernetes administration and troubleshooting
- Azure CLI and cloud infrastructure operations
- High availability and resiliency design
- Backup, rollback, and disaster recovery planning
- YAML and automation scripting
- DevOps documentation and GitHub portfolio presentation

## Next steps
1. Push this repository to GitHub
2. Add screenshots and architecture diagrams
3. Add a live demo or terminal logs section
4. Keep this repository updated with real-world migration lessons

## Copyright / usage
This repository is intended for educational and portfolio use. Adapt the commands and values to your AKS environment before executing in production.

---

This project reflects my hands-on approach to cloud infrastructure, Kubernetes operations, and production-focused decision making.
