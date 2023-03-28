######################################
#     Jumpbox NetworkSecurityGroup
#     cf. https://learn.microsoft.com/en-us/azure/bastion/bastion-nsg#target-vm-subnet
######################################
resource "azurerm_network_security_rule" "allow-jumpbox-rdp-inbound" {
  name                        = "AllowRdpInbound"
  description                 = "Allow https inbound traffic from internet"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = var.bastion_subnet_address_space
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.jumpbox_subnet_nsg.name
}

resource "azurerm_network_security_rule" "allow-jumpbox-ssh-inbound" {
  name                        = "AllowSshInbound"
  description                 = "Allow SSH inbound traffic"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.bastion_subnet_address_space
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.jumpbox_subnet_nsg.name
}

######################################
#     Bastion NetworkSecurityGroup
#     cf. https://learn.microsoft.com/en-us/azure/bastion/bastion-nsg#apply
######################################
# Data plane communication over SSH and RDP (22, 3389) outbounds is allowed by default

resource "azurerm_network_security_rule" "allow-ssh-outbound" {
  name                        = "AllowSshOutbound"
  description                 = "Azure Bastion will reach the target VMs over private IP."
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}

resource "azurerm_network_security_rule" "allow-rdp-outbound" {
  name                        = "AllowRdpOutbound"
  description                 = "Azure Bastion will reach the target VMs over private IP."
  priority                    = 101
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}

resource "azurerm_network_security_rule" "allow-azure-cloud-outbound" {
  name                        = "AllowAzureCloudOutbound"
  description                 = "This is to be able to connect to various public endpoints within Azure."
  priority                    = 104
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "AzureCloud"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}

resource "azurerm_network_security_rule" "allow-http-outbound" {
  name                        = "AllowHttpOutbound"
  description                 = "This is to communicate with the Internet for session, Bastion Shareable Link, and certificate validation."
  priority                    = 105
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}

# Data plane communication (5701, 8080) are allowed by default.
# Azure Load Balancer Inbound for health probes is allowed by default.

resource "azurerm_network_security_rule" "allow-bastion-https-inbound" {
  name                        = "AllowHttpsInbound"
  description                 = "Allow https inbound traffic from internet"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}

resource "azurerm_network_security_rule" "allow-gateway-manager-inbound" {
  name                        = "AllowGatewayManagerInbound"
  description                 = "This is for control plane connectivity"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "GatewayManager"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}

######################################
#     Private NetworkSecurityGroup
######################################
resource "azurerm_network_security_rule" "private-allow-all-outbound" {
  name                        = "private-allow-all-outbound"
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