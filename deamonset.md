```bash
kubectl -n seldon-system patch daemonset seldon-core-analytics-prometheus-node-exporter -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
kubectl -n seldon-system patch daemonset fluentd-fluentd-elasticsearch -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
kubectl -n seldon-system patch daemonset fluentd-fluentd-elasticsearch -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
kubectl  patch daemonset cloudwatch-agent -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
kubectl  patch daemonset fluentd-cloudwatch -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'
kubectl  patch daemonset prometheus-grafana-prometheus-node-exporter -p '{"spec": {"template": {"spec": {"nodeSelector": {"non-existing": "true"}}}}}'


kubectl -n <namespace> patch daemonset <name-of-daemon-set> --type json -p='[{"op": "remove", "path": "/spec/template/spec/nodeSelector/non-existing"}]'

```
