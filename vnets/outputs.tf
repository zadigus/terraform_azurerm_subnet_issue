output "aks_snet_id" {
  value = element([
    for subnet in azurerm_virtual_network.vnet_cluster.subnet :
    subnet.id
    if subnet.name == "AksSubnet"
  ], 0)
}

output "resources_snet_id" {
  value = element([
    for subnet in azurerm_virtual_network.vnet_hub.subnet :
    subnet.id
    if subnet.name == "ResourcesSubnet"
  ], 0)
}

output "hub_vnet_id" {
  value = azurerm_virtual_network.vnet_hub.id
}

output "hub_vnet_name" {
  value = azurerm_virtual_network.vnet_hub.name
}