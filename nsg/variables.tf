variable "location" {
  description = "(required) Region to create the NSG"
  type        = string
}

variable "resource_group_name" {
  description = "(required) Name of the target Resource Group"
  type        = string
}

variable "name_prefix" {
  description = "(required) Resource Name Prefix"
  type        = string
}

variable "name_suffix" {
  description = "(required) Resource Name Suffix"
  type        = string
}

variable "tags" {
  description = "(optional) Some useful information"
  type        = map(any)
  default     = {}
}