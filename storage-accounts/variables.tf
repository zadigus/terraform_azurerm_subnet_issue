variable "resource_group_name" {
  description = "(required) Name of the target Resource Group"
  type        = string
}

variable "name_prefix" {
  description = "(required) Name of the Storage Account to deploy"
  type        = string
}

variable "name_suffix" {
  description = "(required) Suffix of the Name of the Storage Account to deploy"
  type        = string
}

variable "location" {
  description = "(required) Location of Storage Account deployment"
  type        = string
  default     = "eastus"
}

variable "account_tier" {
  description = "(optional) Account Tier of storage account to deploy"
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Argument 'account_tier' must either of 'Standard', or 'Premium'."
  }
}

variable "replication_type" {
  description = "(optional) Replication type of storage account to deploy"
  type        = string
  default     = "LRS"
}

variable "tags" {
  description = "(optional) Additional information for resource management"
  type        = map(any)
  default     = {}
}

variable "subnet_id" {
  description = "(optional) The subnet ID that should be allowed access to this resource"
  type        = list(string)
}

variable "allowed_ips" {
  description = "(optional) The IPv4s that are allowed to access the storage account"
  type        = list(string)
}