output "bastion_subnet_nsg_id" {
  value = azurerm_network_security_group.bastion_subnet_nsg.id
}

output "jumpbox_subnet_nsg_id" {
  value = azurerm_network_security_group.jumpbox_subnet_nsg.id
}

output "private_subnet_nsg_id" {
  value = azurerm_network_security_group.private_subnet_nsg.id
}