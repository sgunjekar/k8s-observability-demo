#!/bin/bash
argocd login localhost:8080 --username admin --password admin
argocd repo add https://github.com/your-org/k8s-observability-demo.git
argocd app create bootstrap --repo https://github.com/your-org/k8s-observability-demo.git --path argocd --dest-server https://kubernetes.default.svc --dest-namespace argocd
