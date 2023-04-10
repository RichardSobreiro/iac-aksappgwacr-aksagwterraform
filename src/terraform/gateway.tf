locals {
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
  backend_address_pool_name      = "${azurerm_virtual_network.vnet.name}-beap"
  http_setting_name              = "${azurerm_virtual_network.vnet.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.vnet.name}-httplstn"
  listener_name_https            = "${azurerm_virtual_network.vnet.name}-httpslstn"
  request_routing_rule_name      = "${azurerm_virtual_network.vnet.name}-rqrt"
  request_routing_rule_name_https= "${azurerm_virtual_network.vnet.name}-rqrt-https"
  frontend_port_name             = "${azurerm_virtual_network.vnet.name}-feport"
  frontend_port_https_name       = "${azurerm_virtual_network.vnet.name}-feport-https"
}

resource "azurerm_application_gateway" "agw" {
  name                = "${var.prefix}-agw-${var.sufix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  sku {
    name     = var.app_gateway_sku
    tier     = var.app_gateway_sku
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "agw-ip-config"
    subnet_id = data.azurerm_subnet.agw_subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_port {
    name = local.frontend_port_https_name
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  identity {
    type         = "UserAssigned"
    identity_ids = ["${azurerm_user_assigned_identity.id.id}"]
  }

  ssl_certificate {
      name     = var.key_vault_ssl_cert_name
      key_vault_secret_id = data.azurerm_key_vault_certificate.ssl_certificate.secret_id
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   = 1 
  }

  http_listener {
    name                           = local.listener_name_https
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_https_name
    protocol                       = "Https"
    ssl_certificate_name           = var.key_vault_ssl_cert_name
  }

  tags = var.tags

  depends_on = [azurerm_virtual_network.vnet, 
    azurerm_public_ip.pip, 
    azurerm_user_assigned_identity.id, 
    azurerm_key_vault_access_policy.policy_aks, 
    azurerm_key_vault_access_policy.policy, 
    azurerm_key_vault_access_policy.policy_current]
}