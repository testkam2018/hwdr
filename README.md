# Node.js Hello World App Deployment
[![CI](https://github.com/testkam2018/hwdr/actions/workflows/blank.yml/badge.svg)](https://github.com/testkam2018/hwdr/actions/workflows/blank.yml)

This repository contains a simple Node.js application that prints "Hello World!" or any other value from the `MESSAGE` environment variable. It includes a comprehensive setup for deploying the application to a Kubernetes cluster using Terraform and Helm, with Ngrok exposing the application to the outside world.

## Prerequisites

1. **Docker:** Ensure Docker is installed and running on your machine.
2. **Terraform:** Install Terraform from the [official site](https://www.terraform.io/downloads.html).
3. **Kubectl:** Install `kubectl` for Kubernetes cluster management.
4. **Ngrok Account:** Create an account on [Ngrok](https://ngrok.com/). You will need the API key and Auth token.
5. **GitHub Account:** For managing secrets and triggering GitHub Actions.

## Directory Structure

```plaintext
.
├── part1
│   ├── app
│   │   ├── app.js
│   ├── test
│   │   ├── app_unit.test.js
│   ├── Dockerfile
│   ├── package.json
│   ├── package-lock.json
│   └── README.md
├── part3
│   ├── tf
│   │   ├── cluster.tf
│   │   ├── ngrok.tf
│   ├── helm
│   │   ├── Chart.yaml
│   │   ├── templates
│   │   │   ├── dpl-general.yml
│   │   │   ├── ingress.yml
│   │   │   ├── svc-general.yml
│   │   └── values.yml
└── .github
    └── workflows
        └── blank.yml

```
## installation and cleanup

Setting Up
Step 1: Configure Ngrok
Sign up on Ngrok.
Obtain your API key and Auth token.
Register a free custom domain on Ngrok.

Step 2: Set Up Environment Variables
Export the Ngrok API key and Auth token as environment variables:
export API_KEY=<your-ngrok-api-key>
export AUTHTOKEN=<your-ngrok-auth-token>

Step 3: Update Helm Values
Edit part3/helm/values.yml to include your Ngrok custom domain and other necessary values like image tag, environment variables, etc. 

```
part3/helm/values.yml
spec:
  module:
    image:
      repository: "<your_dockerhub_username>/hw"
      tag: "20240723174938"
ngrokDomain: <your_ngrok_domain>
MESSAGE: "Hello, World!"
```

Running Terraform
Navigate to the part3/tf directory and apply the Terraform manifests to set up the Kind cluster and Ngrok helm release:

cd part3/tf
terraform init
terraform apply
This will create a Kind Kubernetes cluster and install the Ngrok helm chart.

## Running the Application
Step 1: Build and Push Docker Image
The GitHub Actions pipeline (.github/workflows/blank.yml) is set up to run unit tests, build the Docker image, and push it to Docker Hub. Ensure the repository has the following secrets:

DOCKER_USERNAME
DOCKER_PASSWORD
These secrets can be added in the GitHub repository settings under "Secrets and variables".

Step 2: Trigger GitHub Actions
Push your code to the main branch or manually trigger the GitHub Actions workflow from the Actions tab.

Step 3: Deploy with Helm
Once the Docker image is pushed, deploy the application using Helm. Navigate to the part3/helm directory and run:

```
cd part3/helm
helm upgrade --namespace hw hw --create-namespace --install --wait . -f ./values.yml
```
This command will deploy the Node.js application to your Kubernetes cluster.

Testing the Application
Navigate to your Ngrok custom domain to see the application running. You should see the message "Hello World!" or any other value set in the MESSAGE environment variable.

Running Unit Tests Locally
To run the unit tests locally, navigate to the part1 directory and execute:

```
cd part1
npm install
npm test
```

This will start the server, run the tests, and shut down the server afterwards.

Cleaning Up
To destroy the resources created by Terraform:

```
cd part3/tf
terraform destroy
```
This will remove the Kind cluster and Ngrok helm release.