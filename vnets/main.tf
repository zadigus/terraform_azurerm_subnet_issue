resource "azurerm_virtual_network" "vnet_hub" {
  name                = "HubVnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/22"]

  tags = var.tags
}

resource "azurerm_subnet" "storage" {
  name                 = "StorageSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = ["10.0.2.0/24"]

  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_subnet_network_security_group_association" "storage" {
  subnet_id                 = azurerm_subnet.storage.id
  network_security_group_id = var.private_subnet_nsg_id
}