# Rollback plan

## Trigger conditions
Rollback should be initiated if:

- application availability is below target
- ingress or services fail health checks
- workloads are repeatedly crashing
- scheduler fails to place pods correctly

## Recovery commands
```bash
kubectl uncordon <old-node-name>
kubectl apply -f backup/<namespace>/all.yml
kubectl get pods -A -o wide
kubectl get svc -A
kubectl get ingress -A
```

## Cleanup after rollback
```bash
az aks nodepool delete \
  --resource-group <RG_NAME> \
  --cluster-name <AKS_NAME> \
  --name npzones
```

## Post-incident validation
- ensure workloads are healthy
- verify service endpoints respond
- confirm no crash loops
- verify autoscaling and node distribution
- document cause and prevention for next migration
