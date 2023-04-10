resource "azurerm_user_assigned_identity" "id" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  name = "ric-id-k8s"

  tags = var.tags
}