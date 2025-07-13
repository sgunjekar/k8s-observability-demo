# scripts/argocd-register-repo.sh
#!/bin/bash
ARGOCD_SERVER=localhost:8080
USERNAME=admin
PASSWORD=admin
REPO_URL=https://github.com/sgunjekar/k8s-observability-demo.git

argocd login $ARGOCD_SERVER --username $USERNAME --password $PASSWORD --insecure
argocd repo add $REPO_URL --username $GIT_USER --password $GIT_PASS