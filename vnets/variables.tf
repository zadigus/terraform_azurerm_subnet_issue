variable "location" {
  description = "(required) Region to create the NSG"
  type        = string
}

variable "resource_group_name" {
  description = "(required) Name of the target Resource Group"
  type        = string
}

variable "tags" {
  description = "(optional) Some useful information"
  type        = map(any)
  default     = {}
}

variable "hub_network" {
  description = "(required) Map of address spaces for subnets within the hub vnet"
  type = map(any)
}