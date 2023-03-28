output "fw_snet_id" {
  value = element([
    for subnet in azurerm_virtual_network.vnet_hub.subnet :
    subnet.id
    if subnet.name == local.fw_subnet_name
  ], 0)
}

output "jumpbox_snet_id" {
  value = element([
    for subnet in azurerm_virtual_network.vnet_hub.subnet :
    subnet.id
    if subnet.name == local.jumpbox_subnet_name
  ], 0)
}

output "resources_snet_id" {
  value = element([
    for subnet in azurerm_virtual_network.vnet_hub.subnet :
    subnet.id
    if subnet.name == local.resources_subnet_name
  ], 0)
}

output "hub_gw_snet_id" {
  value = element([
    for subnet in azurerm_virtual_network.vnet_hub.subnet :
    subnet.id
    if subnet.name == local.vpn_gateway_subnet_name
  ], 0)
}

output "inbound_dns_snet_id" {
  value = azurerm_subnet.inbound_dns.id
}

output "database_snet_id" {
  value = azurerm_subnet.psql.id
}

output "azure_bastion_snet_id" {
  value = element([
    for subnet in azurerm_virtual_network.vnet_hub.subnet :
    subnet.id
    if subnet.name == local.azure_bastion_subnet_name
  ], 0)
}

output "aks_vnet_ids" {
  value = values(azurerm_virtual_network.vnet_cluster)[*].id
}

output "aks_vnet_names" {
  value = values(azurerm_virtual_network.vnet_cluster)[*].name
}

output "aks_snet_ids" {
  value = values(azurerm_subnet.aks)[*].id
}

output "hub_vnet_id" {
  value = azurerm_virtual_network.vnet_hub.id
}

output "hub_vnet_name" {
  value = azurerm_virtual_network.vnet_hub.name
}