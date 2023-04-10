data "azurerm_client_config" "default" {}

data "azurerm_key_vault" "kv" {
  name                = "${var.key_vault_name}"
  resource_group_name = "${var.key_vault_resource_group_name}"
}

resource "azurerm_key_vault_access_policy" "policy_current" {
  key_vault_id        = data.azurerm_key_vault.kv.id
  tenant_id           = data.azurerm_client_config.default.tenant_id
  object_id           = data.azurerm_client_config.default.object_id

  key_permissions = [
    "Get"
  ]

  secret_permissions = [
    "Get"
  ]

  certificate_permissions = [
    "Get"
  ]

}

resource "azurerm_key_vault_access_policy" "policy" {
  key_vault_id        = data.azurerm_key_vault.kv.id
  tenant_id           = data.azurerm_client_config.default.tenant_id
  object_id           = azuread_service_principal.spr.object_id

  key_permissions = [
    "Get"
  ]

  secret_permissions = [
    "Get"
  ]

  certificate_permissions = [
    "Get"
  ]

  depends_on = [azuread_service_principal.spr] 
}

resource "azurerm_key_vault_access_policy" "policy_aks" {
  key_vault_id        = data.azurerm_key_vault.kv.id
  tenant_id           = data.azurerm_client_config.default.tenant_id
  object_id           = azurerm_user_assigned_identity.id.principal_id

  key_permissions = [
    "Get"
  ]

  secret_permissions = [
    "Get"
  ]

  certificate_permissions = [
    "Get"
  ]

  depends_on = [azurerm_user_assigned_identity.id, azuread_service_principal.spr] 
}

data "azurerm_key_vault_secret" "secret_ssh" {
  name         = var.key_vault_secret_ssh_name
  key_vault_id = data.azurerm_key_vault.kv.id

  depends_on = [azurerm_key_vault_access_policy.policy_current] 
}

data "azurerm_key_vault_certificate" "ssl_certificate" {
  name         = var.key_vault_ssl_cert_name
  key_vault_id = data.azurerm_key_vault.kv.id

  depends_on = [azurerm_key_vault_access_policy.policy_current]
}