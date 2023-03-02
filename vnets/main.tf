resource "azurerm_virtual_network" "vnet_cluster" {
  name                = "AksVnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.4.0/22"]

  tags = var.tags

  subnet {
    name           = "AksSubnet"
    address_prefix = "10.0.5.0/24"
    security_group = var.private_subnet_nsg_id
  }
}

resource "azurerm_virtual_network" "vnet_hub" {
  name                = "HubVnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/22"]

  tags = var.tags

  subnet {
    name           = "ResourcesSubnet"
    address_prefix = "10.0.2.0/24"
    security_group = var.private_subnet_nsg_id
  }
}