# scripts/test-deployments.sh
#!/bin/bash
kubectl get pods --all-namespaces
kubectl get svc --all-namespaces
kubectl get application -n argocd

echo "Checking Grafana..."
kubectl port-forward svc/grafana -n default 3000:3000 &
echo "Visit Grafana: http://localhost:3000"
