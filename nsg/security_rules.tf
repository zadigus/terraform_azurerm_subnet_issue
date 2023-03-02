######################################
#     Private NetworkSecurityGroup
######################################
resource "azurerm_network_security_rule" "private-allow-all-outbound" {
  name                        = format(
    "%s_%s_%s",
    var.name_prefix,
    "private-allow-all-outbound",
    var.name_suffix
  )
  description                 = "Allow Traffic to outside the private network"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "0.0.0.0/0"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.private_subnet_nsg.name
}