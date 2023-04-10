data "azurerm_subscription" "current" {
}

output "subscription_display_name" {
  value = data.azurerm_subscription.current.display_name
}

output "subscription_subscription_id" {
    value = data.azurerm_subscription.current.subscription_id
}

output "resource_group_name" {
    value = azurerm_resource_group.rg.name
}

output "application_gateway_name" {
    value = azurerm_application_gateway.agw.name
}

output "container_registry_name" {
    value = azurerm_container_registry.acr.name
}

output "client_key" {
    value = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
    sensitive = true
}

output "client_certificate" {
    value = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
    sensitive = true
}

output "cluster_ca_certificate" {
    value = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
    sensitive = true
}

output "cluster_username" {
    value = azurerm_kubernetes_cluster.aks.kube_config.0.username
    sensitive = true
}

output "cluster_password" {
    value = azurerm_kubernetes_cluster.aks.kube_config.0.password
    sensitive = true
}

output "kube_config" {
    value = azurerm_kubernetes_cluster.aks.kube_config_raw
    sensitive = true
}

output "host" {
    value = azurerm_kubernetes_cluster.aks.kube_config.0.host
    sensitive = true
}

output "identity_resource_id" {
    value = azurerm_user_assigned_identity.id.id
}

output "identity_client_id" {
    value = azurerm_user_assigned_identity.id.client_id
}

output "service_principal_application_id" {
    value = azuread_service_principal.spr.application_id
}

output "service_principal_password" {
    value = azuread_service_principal_password.sps.value
    sensitive = true
}

output "public_ip_address" {
  value = azurerm_public_ip.pip.ip_address
}

output "domain_name_label" {
  value = azurerm_public_ip.pip.domain_name_label
}

output "fqdn" {
  value = azurerm_public_ip.pip.fqdn
}

output "container_registry_login_server" {
    value = azurerm_container_registry.acr.login_server
}

output "container_registry_admin_username" {
    value = azurerm_container_registry.acr.admin_username
}

output "container_registry_admin_password" {
    value = azurerm_container_registry.acr.admin_password
    sensitive = true
}

output "container_registry_id" {
    value = azurerm_container_registry.acr.id
}

output "azuread_service_principal_object_id" {
    value = azuread_service_principal.spr.object_id
}

output "azuread_service_principal_id" {
    value = azuread_service_principal.spr.id
}

output "azuread_service_principal_application_id" {
    value = azuread_service_principal.spr.application_id
}

