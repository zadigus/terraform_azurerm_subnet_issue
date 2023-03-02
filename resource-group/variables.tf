# Configure Azure Services to Create
variable "group_prefix" {
  description = "(Required) Prefix of resource group name"
  type        = string
}

variable "location" {
  description = "(Required) Azure Region to create the resource"
  type        = string
}

variable "resource_group_tags" {
  description = "(optional) Additional information for resource management"
  type        = map(any)
  default     = {}
}