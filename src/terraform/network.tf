resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet-${var.sufix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.virtual_network_address_prefix]

  subnet {
    name           = var.aks_subnet_name
    address_prefix = var.aks_subnet_address_prefix
  }

  subnet {
    name           = var.app_gateway_subnet_name
    address_prefix = var.app_gateway_subnet_address_prefix
  }

  tags = var.tags
}

data "azurerm_subnet" "k8s_subnet" {
  name                 = var.aks_subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  depends_on           = [azurerm_resource_group.rg]
}

data "azurerm_subnet" "agw_subnet" {
  name                 = var.app_gateway_subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  depends_on           = [azurerm_resource_group.rg]
}

resource "azurerm_public_ip" "pip" {
  name                         = "${var.prefix}-pip-${var.sufix}"
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  allocation_method            = var.public_ip_allocation
  sku                          = var.public_ip_sku
  domain_name_label            = "${var.prefix}-k8s"

  tags = var.tags
}