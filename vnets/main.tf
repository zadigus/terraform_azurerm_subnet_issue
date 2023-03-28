resource "azurerm_virtual_network" "vnet_hub" {
  name                = "HubVnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.hub_network["vnet"]]

  tags = var.tags
}

resource "azurerm_subnet" "fw" {
  name                 = local.fw_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [var.hub_network["firewall"]]
}

resource "azurerm_subnet" "gw" {
  name                 = local.vpn_gateway_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [var.hub_network["vpn_gateway"]]
}

resource "azurerm_subnet" "jumpbox" {
  name                 = local.jumpbox_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [var.hub_network["jumpbox"]]
}

resource "azurerm_subnet" "bastion" {
  name                 = local.azure_bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [var.hub_network["bastion"]]
}

resource "azurerm_subnet" "resources" {
  name                 = local.resources_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [var.hub_network["resources"]]
}

resource "azurerm_subnet" "inbound_dns" {
  name                 = local.inbound_dns_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [var.hub_network["inbounddns"]]

  delegation {
    name = "Microsoft.Network.dnsResolvers"

    service_delegation {
      name    = "Microsoft.Network/dnsResolvers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet" "psql" {
  name                 = local.database_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefixes     = [var.hub_network["database"]]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}