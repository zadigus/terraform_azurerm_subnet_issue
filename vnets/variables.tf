variable "location" {
  description = "(required) Region to create the NSG"
  type        = string
}

variable "resource_group_name" {
  description = "(required) Name of the target Resource Group"
  type        = string
}

variable "bastion_subnet_nsg_id" {
  description = "(required) Network Security Group Id of the Bastion Subnet"
  type        = string
}

variable "jumpbox_subnet_nsg_id" {
  description = "(required) Network Security Group Id of the Jumpbox Subnet"
  type        = string
}

variable "private_subnet_nsg_id" {
  description = "(required) Private Network Security Group Id of the Subnet"
  type        = string
}

variable "tags" {
  description = "(optional) Some useful information"
  type        = map(any)
  default     = {}
}

variable "aks_networks" {
  description = "(required) List of Vnets / Subnets for AKS clusters"
  type = list(object({
    vnet   = list(string)
    subnet = list(string)
  }))
}

variable "hub_network" {
  description = "(required) Map of address spaces for subnets within the hub vnet"
  # TODO: this should be map(list(string))
  type = map(any)
}