# Azure Portal Queries for Screenshots

## Application Insights - Custom Events Query

```kusto
customEvents
| where name == "Dogs" or name == "Cats"
| project timestamp, name, customDimensions
| order by timestamp desc
| take 100
```

## Application Insights - Custom Events Chart

```kusto
customEvents
| where name in ("Dogs", "Cats")
| summarize EventCount = count() by name, bin(timestamp, 5m)
| render timechart
```

## Application Insights - Traces Query

```kusto
traces
| where message contains "Dogs" or message contains "Cats"
| project timestamp, message, severityLevel, customDimensions
| order by timestamp desc
| take 100
```

## Application Insights - Traces Chart

```kusto
traces
| where message contains "Vote"
| summarize count() by bin(timestamp, 5m)
| render timechart
```

## Application Insights - All Telemetry

```kusto
union customEvents, traces, requests
| where timestamp > ago(1h)
| project timestamp, itemType, name, message
| order by timestamp desc
| take 100
```

---

## Screenshot Checklist

### Application Insights (need 5-7 screenshots):
- [ ] VMSS Metrics (5 graphs: CPU, Memory, Disk, Network In, Network Out)
- [ ] Custom Events (showing Dogs & Cats)
- [ ] Custom Events Query results
- [ ] Custom Events Chart
- [ ] Traces Query results
- [ ] (Optional) Traces Chart

### Kubernetes (need 3 screenshots):
- [ ] HPA & Pods output (kubectl get hpa && kubectl get pods)
- [ ] Pod metrics in Azure Portal
- [ ] Alert email from your inbox

### VMSS Autoscaling (already have 10):
- [x] Complete

### RunBook (already have 3):
- [x] Complete

---

## File Naming Convention

Save screenshots as:
- `vmss-metrics-5-graphs.png`
- `custom-events-dogs-cats.png`
- `custom-events-query.png`
- `custom-events-chart.png`
- `traces-query.png`
- `hpa-pods-output.png`
- `pod-metrics-azure.png`
- `alert-email-pods.png`
