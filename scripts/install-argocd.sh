# Placeholder for install-argocd.sh
#!/bin/bash

echo "🚀 Installing Argo CD..."
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "✅ Argo CD installed. Access via port-forward:"
echo "   kubectl port-forward svc/argocd-server -n argocd 8080:443"
