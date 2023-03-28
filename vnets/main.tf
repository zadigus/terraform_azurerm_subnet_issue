resource "azurerm_virtual_network" "vnet_cluster" {
  for_each = { for idx, addr in var.aks_networks : idx => addr }

  name                = "AksVnet-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = each.value["vnet"]

  tags = var.tags
}

resource "azurerm_subnet" "aks" {
  for_each = { for idx, addr in var.aks_networks : idx => addr }

  name                 = "AksSubnet-${each.key}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_cluster[each.key].name
  address_prefixes     = each.value["subnet"]
  # this is necessary to give the aks cluster access to the storage account
  # (only if the storage account is private)
  service_endpoints    = ["Microsoft.Storage"]
}

resource "azurerm_subnet_network_security_group_association" "aks" {
  for_each = { for idx, addr in var.aks_networks : idx => addr }

  subnet_id                 = azurerm_subnet.aks[each.key].id
  network_security_group_id = var.private_subnet_nsg_id
}

# TODO: make sure the installation of this whole vnet is re-entrant
resource "azurerm_virtual_network" "vnet_hub" {
  name                = "HubVnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.hub_network["vnet"]]

  tags = var.tags

  subnet {
    # this subnet is special for azure; it must have this name
    # and cannot be provided with a network security group
    name           = local.fw_subnet_name
    address_prefix = var.hub_network["firewall"]
  }

  subnet {
    name           = local.vpn_gateway_subnet_name
    address_prefix = var.hub_network["vpn_gateway"]
  }

  subnet {
    name           = local.jumpbox_subnet_name
    address_prefix = var.hub_network["jumpbox"]
    security_group = var.jumpbox_subnet_nsg_id
  }

  subnet {
    # this name must be AzureBastionSubnet, otherwise, it doesn't work
    # azure won't accept another name
    name           = local.azure_bastion_subnet_name
    address_prefix = var.hub_network["bastion"]
    security_group = var.bastion_subnet_nsg_id
  }

  subnet {
    name           = local.resources_subnet_name
    address_prefix = var.hub_network["resources"]
    security_group = var.private_subnet_nsg_id
  }
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

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet_network_security_group_association" "inbound_dns" {
  subnet_id                 = azurerm_subnet.inbound_dns.id
  network_security_group_id = var.private_subnet_nsg_id
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

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet_network_security_group_association" "db" {
  subnet_id                 = azurerm_subnet.psql.id
  network_security_group_id = var.private_subnet_nsg_id
}