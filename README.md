
# Create GKE cluster using Terraform - Nginx Ingress & TLS - OIDC Workload Identity

## Create GKE cluster using Terraform

```bash
# Authenticate with your GCP account
gcloud auth login

# List available GCP projects
gcloud projects list

# Set your desired GCP project
gcloud config set project <project_id>

# Initialize Terraform
terraform init

# Apply Terraform configuration to create GKE cluster
terraform apply

# Configure `kubectl` to connect to the newly created GKE cluster
gcloud container clusters get-credentials <cluster_name> --region <region> --project <project_id>

```

## Deploy Ingress Controller

```bash
# Install Nginx Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.0/deploy/static/provider/cloud/deploy.yaml


```

## Create Public and Private load balancers

```bash
# Apply example service configuration
kubectl apply -f k8s/1-example

# Get service details
kubectl get svc

```

## Auto-Scaling

```bash
# Check current nodes
kubectl get nodes

# Apply example deployment configuration with autoscaling
kubectl apply -f k8s/2-example

# Monitor pods
kubectl get pods
kubectl describe pods nginx-v2-<pod_id>

# Monitor nodes for autoscaling
kubectl get nodes

```

## Create an Ingress using Nginx Ingress

```bash
# Check Nginx Ingress Controller service
kubectl get svc -n ingress

# Apply example Ingress configuration
kubectl apply -f k8s/3-example

# Monitor pods
kubectl get pods

# Monitor Ingress
kubectl get ing

# Test Ingress
curl --resolve "echo.eternalamit5.pvt:80:<ingress_ip>" http://echo.eternalamit5.pvt/

```

## Secure the Ingress with TLS & Cert-manager

```bash
k# Apply Cert-manager
kubectl apply -f k8s/4-example

# Monitor pods
kubectl get pods

# Monitor Ingress and Certificates
kubectl get ing
kubectl get Certificate

# Describe Certificate resources for details
kubectl describe Certificate
kubectl describe CertificateRequest
kubectl describe Order
kubectl describe Challenge

# Verify Ingress and Certificate
kubectl get ing
kubectl get Certificate

# Verify DNS resolution
dig echo.eternalamit5.com

```

## Test Workload Identity

```bash
# Apply example workload identity configuration
kubectl apply -f k8s/5-example

# Check pods in dev namespace
kubectl get pods -n dev

# Enter Azure CLI pod
kubectl exec -it azure-cli-<pod_id> -n dev -- sh

# Authenticate with Azure CLI using federated token
az login --federated-token "$(cat $AZURE_FEDERATED_TOKEN_FILE)" --service-principal -u $AZURE_CLIENT_ID -t $AZURE_TENANT_ID

# List storage blobs (example)
az storage blob list -c test --account-name <storage_account_name>

# Clean up workload identity resources
kubectl delete -f k8s/5-example

```

