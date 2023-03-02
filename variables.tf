variable "teamcity_agent_ip" {
  description = "(required) Teamcity Agent IP"
  type        = string
}

variable "location" {
  description = "(required) Region to create the resource"
  type        = string
}

variable "ARM_CLIENT_ID" {
  description = "(required) Client ID for Azure app registration"
  type        = string
}

variable "ARM_CLIENT_SECRET" {
  description = "(required) Client secret for Azure app registration"
  type        = string
}

variable "ARM_TENANT_ID" {
  description = "(required) Tenant ID for Azure"
  type        = string
}

variable "ARM_SUBSCRIPTION_ID" {
  description = "(required) Subscription ID for Azure"
  type        = string
}

variable "jira_project_id" {
  description = "(required) Jira Project ID used as a suffix for most resource names"
  type        = string
}

variable "project_name" {
  description = "(required) Project name mostly used as a prefix for resource names"
  type        = string
}

variable "resource_group_tags" {
  description = "(optional) Some useful information"
  type        = map(any)
  default     = {}
}

###########################################################
#  Storage Accounts Variables
###########################################################
variable "storage_acc_account_tier" {
  description = "(optional) Account Tier of storage account to deploy"
  type        = string
  default     = "Standard"
}

variable "storage_acc_tags" {
  description = "(optional) Some useful information for storage account"
  type        = map(any)
  default     = {}
}

variable "storage_acc_replication_type" {
  description = "(optional) Replication type of storage account to deploy"
  type        = string
  default     = "LRS"
}