resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg-${var.sufix}"
  location = var.location

  tags = var.tags
}