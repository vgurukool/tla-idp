#!/bin/bash
set -e -o pipefail

REPO_ROOT=$(git rev-parse --show-toplevel)
SETUP_DIR="${REPO_ROOT}/setups"
TF_DIR="${REPO_ROOT}/terraform"
source ${REPO_ROOT}/setups/utils.sh

cd ${SETUP_DIR}

echo -e "${PURPLE}\nTargets:${NC}"
echo "Kubernetes cluster: $(kubectl config current-context)"
echo "AWS profile (if set): ${AWS_PROFILE}"
echo "AWS account number: $(aws sts get-caller-identity --query "Account" --output text)"

echo -e "${RED}\nAre you sure you want to continue?${NC}"
read -p '(yes/no): ' response
if [[ ! "$response" =~ ^[Yy][Ee][Ss]$ ]]; then
  echo 'exiting.'
  exit 0
fi

cd "${TF_DIR}"
terraform destroy

cd "${SETUP_DIR}/argocd/"
./uninstall.sh
cd - 

# delete up tla-lrs. 
echo "deleting tla-lrs apps using argocd"
cd "${REPO_ROOT}/terraform/templates/argocd-apps/"

argoPass=$(kubectl -n argocd get secret argocd-initial-admin-secret \
    -o jsonpath="{.data.password}" | base64 -d)

argocd login --grpc-web argocd.tlaidp.com --username admin --password $argoPass

argocd app delete tla-lrs --file tla-lrs.yaml
cd -
echo "tla lrs app deleted"