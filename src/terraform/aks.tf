resource "azurerm_kubernetes_cluster" "aks" {
  name       = "${var.prefix}-aks-${var.sufix}-01"
  location   = azurerm_resource_group.rg.location
  dns_prefix = var.aks_dns_prefix
  http_application_routing_enabled = true
  resource_group_name = azurerm_resource_group.rg.name
  node_resource_group = "${var.prefix}-rg-aks-${var.sufix}-01"

  linux_profile {
    admin_username = var.vm_user_name

    ssh_key {
      key_data = data.azurerm_key_vault_secret.secret_ssh.value
    }
  }

  default_node_pool {
    name                    = "akslinuxpool"
    node_count              = var.aks_agent_count
    vm_size                 = var.aks_agent_vm_size
    os_disk_size_gb         = var.aks_agent_os_disk_size
    vnet_subnet_id          = data.azurerm_subnet.k8s_subnet.id
    max_pods                = var.max_pods_default_node
    enable_auto_scaling     = true
    max_count               = 2
    min_count               = 1
  }

  service_principal {
    client_id     = azuread_service_principal.spr.application_id
    client_secret = azuread_service_principal_password.sps.value
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = var.aks_dns_service_ip
    service_cidr       = var.aks_service_cidr
  }

  depends_on = [azurerm_virtual_network.vnet, azurerm_application_gateway.agw
    , azuread_service_principal_password.sps
    , azuread_service_principal.spr
    , azurerm_role_assignment.role_acrpull]

  tags       = var.tags
}