# Risk mitigation strategy for AKS migration

## Risk table
| Risk | Impact | Mitigation |
|---|---|---|
| Single-zone failure | Service disruption | Add multi-zone node pool before cutover |
| Pod disruption during drain | Application latency or downtime | Drain with controlled validation and monitor events |
| Ingress disruption | User-facing errors | Validate service health before removal |
| Stateful workload issues | Restart or persistence problems | Confirm storage and app constraints |
| Capacity issues | Scheduling failures | Validate node count and VM sizing |
| Rollback delay | Longer outage | Backup manifests and maintain clear rollback steps |

## Best practice checklist
- Validate cluster inventory before migration
- Keep backup manifests ready
- Use PDBs for critical applications
- Stage workload movement gradually
- Confirm ingress and networking health
- Only delete old pools after validation
