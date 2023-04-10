<!-- @format -->

# How to Create Azure Kubernetes Service, Azure Application Gateway, and Azure Container Registry using Azure DevOps and Terraform

## Overview

## Pre-Requisites

To debug this overall tutorial and get the most of it, it's nice to have the following tools installed in your local environment:

- [Helm 3](https://helm.sh/docs/intro/install/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)

## Create the Azure Key Vault

[Here we can find all the steps required to create the Azure Key Vault Resource with the SSH Public Key secret and the self-signed certificate that will be used in the Application Gateway.](https://github.com/RichardSobreiro/iac-azurekeyvault-aksagwterraform)

## The Terraform Code

## Build Pipeline

## Build .NET 6 API and deploy to Container Registry

## Build and Deploy the Helm Chart to Container Registry

## Deploy .NET 6 API to AKS cluster

## Login to AKS Cluster

az login
az aks get-credentials --resource-group ric-eastus-all-rg-k8s --name ric-eastus-all-aks-k8s-01
kubectl get pods --all-namespaces

kubectl describe pods ingress-azure-1680865526-64cbd79678-jtt76 -n default
kubectl logs ingress-azure-1680865526-64cbd79678-jtt76 -n default

kubectl describe pods sampleapi-989b55969-5vdfj -n backend-apps
kubectl logs sampleapi-989b55969-5vdfj -n backend-apps

### Troubleshooting

You need to have Helm 3 and Azure CLI installed before starting a troubleshoot proccess.

_Don't forget to run az login and az aks get-credentials before the following commands._

Commands:

- Delete Helm Release for AGIC

```
helm delete ingress-azure
```

- Intall AGIC

The commands helm repo add and helm repo update must be executed only once.

```
helm repo add application-gateway-kubernetes-ingress https://appgwingress.blob.core.windows.net/ingress-azure-helm-package
helm repo update
helm install ingress-azure -f helm-config.yaml application-gateway-kubernetes-ingress/ingress-azure --version 1.6.0
```

- Delete Kubeconfig Context

```
kubectl config delete-context ric-eastus-all-aks-k8s-01
```

Troubleshooting AGIC: https://azure.github.io/application-gateway-kubernetes-ingress/troubleshootings/

## Navigate to https://ric-eastus-all-k8s.eastus.cloudapp.azure.com/swagger

az role assignment create --role Reader --scope '/subscriptions/d274f0d8-ca3f-46f0-8840-b906d7527220/resourceGroups/ric-eastus-all-rg-k8s' --assignee 7a32ea32-f5d2-45c1-ba0f-a828d5189800

az role assignment create --role Contributor --scope /subscriptions/d274f0d8-ca3f-46f0-8840-b906d7527220/resourceGroups/ric-eastus-all-rg-k8s/providers/Microsoft.Network/applicationGateways/ric-eastus-all-agw-k8s --assignee 7a32ea32-f5d2-45c1-ba0f-a828d5189800'
