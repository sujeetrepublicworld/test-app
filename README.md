# GKE Cluster Setup with Terraform, ArgoCD, and CI/CD Pipeline

This repository contains Terraform configuration files used to set up a **private VPC** with a **subnetwork**, **Google Kubernetes Engine (GKE) Cluster**, **VM instance**, **firewall rules**, and an **ArgoCD CI/CD pipeline**. Additionally, **Cert-Manager** was set up for **SSL/TLS** certificates, and a **test app** was deployed using **ArgoCD**.

## Infrastructure Overview

1. **Private VPC**: A private Virtual Private Cloud (VPC) was created to isolate network traffic and provide security.
2. **Subnetwork**: A subnet within the private VPC was created for use by the GKE cluster and other resources.
3. **GKE Cluster**: A private Google Kubernetes Engine (GKE) cluster was created within the VPC.
4. **VM Instance**: A **Bastion Host** VM instance was created for secure SSH access to the private network.
5. **Firewall Rules**: Custom firewall rules were applied to allow communication between the necessary resources:
    - Allow traffic from the Bastion Host (SSH access).
    - Allow internal communication within the private network.
6. **ArgoCD Setup**: **ArgoCD** was installed and configured on the GKE cluster for **Continuous Deployment**.
7. **CI/CD Integration**: The Git repository was connected to ArgoCD for automated deployments.
8. **Cert-Manager**: **Cert-Manager** was installed to manage SSL/TLS certificates for the applications deployed in the cluster.
9. **Test Application Deployment**: A simple test application was deployed on the GKE cluster via ArgoCD.

## Setup Instructions

### Prerequisites

- **Google Cloud Account** with necessary IAM permissions.
- **Terraform** installed on your machine.
- **kubectl** installed and configured to interact with your GKE cluster.
- **Helm** installed for managing Kubernetes charts.
- **ArgoCD** and **Cert-Manager** installed in your GKE cluster.

### Steps to Reproduce the Infrastructure

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/your-repo/terraform-gke-argocd.git
    cd terraform-gke-argocd
    ```

2. **Initialize Terraform**:
    ```bash
    terraform init
    ```

3. **Create Private VPC, Subnetwork, and Other Resources**:
    Run the following command to create the infrastructure:
    ```bash
    terraform apply
    ```

    - This will:
      - Create a **Private VPC** with a **subnetwork**.
      - Set up a **Google Kubernetes Engine (GKE)** cluster in the private network.
      - Deploy a **Bastion Host** VM for secure SSH access.
      - Apply necessary **Firewall Rules** to allow internal traffic and SSH access.

4. **Install ArgoCD on the GKE Cluster**:
    After Terraform provisioning, install **ArgoCD** to manage the CI/CD pipeline on the cluster. You can either use `kubectl` or Helm to install ArgoCD:

    - Using Helm:
      ```bash
      helm install argo-cd argo/argo-cd --namespace argocd --create-namespace
      ```

    - Or using `kubectl` directly, refer to [ArgoCD Installation Guide](https://argoproj.github.io/argo-cd/).

5. **Set up Continuous Deployment with Git**:
    - Connect your Git repository (containing your Kubernetes manifests or Helm charts) to ArgoCD.
    - Configure the **GitOps** pipeline in ArgoCD to trigger automatic deployments to the GKE cluster.

6. **Install Cert-Manager for SSL/TLS Certificates**:
    Install **Cert-Manager** to handle the creation and management of SSL/TLS certificates for your applications:

    - Using Helm:
      ```bash
      helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace
      ```

    - Create an **Issuer** or **ClusterIssuer** resource to configure **Let's Encrypt** or your preferred certificate provider.

7. **Deploy a Test Application**:
    - A sample test application was deployed using **ArgoCD**. The application is configured to pull from the Git repository and deploy automatically when changes are made.

    - Once ArgoCD is set up, you can deploy the test application via the ArgoCD UI or using `kubectl` commands to sync the application.

### Accessing ArgoCD

1. **Access the ArgoCD Web UI**:
    - To access the ArgoCD web UI, forward the ArgoCD server service to your local machine:
      ```bash
      kubectl port-forward svc/argo-cd-server -n argocd 8080:80
      ```
    - Open your browser and visit: [http://localhost:8080](http://localhost:8080)
    - **Default Credentials**:
      - **Username**: `admin`
      - **Password**: Retrieve the initial password using the following command:
        ```bash
        kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode
        ```

2. **Monitor Application Deployments**:
    Use the ArgoCD UI to monitor the deployments of applications, rollbacks, and view logs.

### Troubleshooting

- If you encounter issues with ArgoCD syncing, check the **ArgoCD logs** for errors:
  ```bash
  kubectl logs -n argocd -l app.kubernetes.io/name=argocd-server



### chek url test https://argocd.sujeetkushwaha.shop
### user id admin
### password 8M40img62rlRSUyD

## grafana               https://grafana.sujeetkushwaha.shop
### user admin
### pass 8yajd7Ogrf9zquOEa3PNagQPAPCtSL5filg7Xqyx

## prometheus              https://prometheus.sujeetkushwaha.shop
