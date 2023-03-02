resource "azurerm_network_security_group" "private_subnet_nsg" {
  name                = format(
    "%s_%s_%s",
    var.name_prefix,
    "private_network_security_group",
    var.name_suffix
  )
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}