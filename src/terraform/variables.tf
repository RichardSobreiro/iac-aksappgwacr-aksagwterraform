# Principal
variable "prefix" {
  description = "Prefix used to name resources."
}

variable "sufix" {
  description = "Prefix used to name resources."
}

# Azure AD Application
variable "azuread_application"{
  description = "Name of the Azure AD application."
  default = "AKSTerraformIaC"
}

# Resource Group
variable "location" {
  description = "Cluster Azure Region."
}

# Network
variable "virtual_network_address_prefix" {
  description = "Virtual network addresses prefix."
  default     = "15.0.0.0/8"
}

variable "aks_subnet_name" {
  description = "AKS subnet name"
  default     = "k8s-subnet"
}

variable "aks_subnet_address_prefix" {
  description = "AKS subnet CIDR addresses"
  default     = "15.1.0.0/16"
}

variable "app_gateway_subnet_name" {
  description = "Application gateway subnet name."
  default     = "agw-subnet"
}

variable "app_gateway_subnet_address_prefix" {
  description = "AKS subnet addresses"
  default     = "15.0.0.0/16"
}

variable "public_ip_allocation" {
  description = "Public IP mode."
  default     = "Static"
}

variable "public_ip_sku" {
  description = "Public IP SKU."
  default     = "Standard"
}

# Key Vault
variable "key_vault_resource_group_name" {
  description = "Key Vault resource group name."
  default = "ric-eastus-all-rg-vault"
}

variable "key_vault_name" {
  description = "Key Vault name."
  default = "ric-eastus-all-kv-vault"
}

variable "key_vault_ssl_cert_name" {
  description = "SSL certificate name."
  default = "x509selfsigned"
}

variable "key_vault_secret_ssh_name" {
  description = "Name of the SSH private key secret."
  default = "ssh-public-key"
}

# Gateway
variable "app_gateway_sku" {
  description = "Application Gateway SKU."
  default = "Standard_v2"
}

# Container Registry
variable "container_registry_sku" {
  description = "Container Registry SKU."
  default = "Basic"
}

# Kubernetes
variable "aks_dns_prefix" {
  description = "AKS DNS prefix"
  default     = "aks"
}

variable "vm_user_name" {
  description = "AKS VMs username"
  default     = "ric-k8s-admin"
}

variable "aks_agent_count" {
  description = "AKS cluster node quantity."
  default     = 1
}

variable "aks_agent_vm_size" {
  description = "AKS cluster VM SKU."
  default     = "Standard_D2_v3"
}

variable "max_pods_default_node" {
  description = "Maximum number of pods per node."
  default     = "250"
}

variable "aks_agent_os_disk_size" {
  description = "VM disk size."
  default     = 64
}

variable "aks_kubernetes_version" {
  description = "Kubernetes version."
  default = "1.26.3"
}

variable "aks_service_cidr" {
  description = "CIDR addresses to use inside kubernetes cluster."
  default     = "10.0.0.0/16"
}

variable "aks_dns_service_ip" {
  description = "DNS address for container server inside AKS."
  default     = "10.0.0.10"
}

variable "aks_docker_bridge_cidr" {
  description = "Docker bridge CIDR addresses."
  default     = "172.17.0.1/16"
}

# Tags
variable "tags" {
  type = map

  default = {
    Creation = "terraform"
    Project = "personal-profile"
  }
}