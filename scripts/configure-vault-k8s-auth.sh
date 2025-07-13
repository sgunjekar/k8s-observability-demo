#!/bin/bash

VAULT_ADDR=http://vault.default.svc.cluster.local:8200
VAULT_TOKEN=root  # replace for prod

# Enable K8s Auth
vault auth enable kubernetes

# Configure K8s Auth
vault write auth/kubernetes/config \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host="https://$KUBERNETES_PORT_443_TCP_ADDR:443" \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt

# Create role for user-service
vault write auth/kubernetes/role/user-service \
    bound_service_account_names=user-service \
    bound_service_account_namespaces=default \
    policies=user-service \
    ttl=24h
