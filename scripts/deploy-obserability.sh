#!/bin/bash

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

kubectl create namespace observability --dry-run=client -o yaml | kubectl apply -f -

helm upgrade --install loki grafana/loki -n observability
helm upgrade --install promtail grafana/promtail -n observability
helm upgrade --install grafana grafana/grafana \
  --namespace observability \
  --set adminPassword='admin123' \
  --set service.type=LoadBalancer
