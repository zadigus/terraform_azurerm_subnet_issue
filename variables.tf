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

###########################################################
#  Storage Containers Variables
###########################################################
variable "storage_acc_containers" {
  description = "(required) Comma-separated list of container names to deploy"
  type        = string
}

###########################################################
#  Container Registries Variables
###########################################################
variable "container_reg_tags" {
  description = "(optional) Some useful information"
  type        = map(any)
  default     = {}
}

variable "container_reg_geo_replication" {
  description = "(optional) A set of geo-replication used for this Container Registry"
  type        = list(string)
  default     = []
}

###########################################################
#  Kubernetes Clusters Variables
###########################################################
variable "log_analytics_workspace_sku" {
  description = "SKU type of log analytics workspace"
  type        = string
  default     = "PerGB2018"
}

variable "aks_sku_tier" {
  description = "(optional) SKU Tier"
  type        = string
  default     = "Standard"
}

variable "aks_tags" {
  description = "(optional) Some useful information"
  type        = map(any)
  default     = {}
}

variable "kubernetes_version" {
  description = "(required) Kubernetes version (e.g. 1.21.9)"
  type        = string
}

variable "aks_cpu_node_pool_min_count" {
  description = "(required) Minimal number of CPU nodes"
  type        = string
}

variable "aks_cpu_node_pool_max_count" {
  description = "(required) Maximal number of CPU nodes"
  type        = string
}

###########################################################
#  Kubernetes Clusters GPU Node Pool Variables
###########################################################
variable "add_gpu_node_pool" {
  description = "(optional) Option to add or not GPU node pool"
  type        = bool
  default     = false
}

variable "aks_gpu_node_pool_name" {
  description = "(optional) Name of the GPU node pool for Kubernetes Cluster"
  type        = string
  default     = "gpupool"
}

variable "aks_gpu_node_pool_vm_size" {
  description = "(optional) Size of virtual machine for GPU node pool"
  type        = string
  default     = "Standard_NC4as_T4_v3"
}

variable "aks_gpu_node_pool_min_count" {
  description = "(optional) Minimum number of GPU nodes"
  type        = number
  default     = 0
}

variable "aks_gpu_node_pool_max_count" {
  description = "(optional) Maximum number of GPU nodes"
  type        = number
  default     = 3
}

###########################################################
#  PostgreSQL Flexible Server
###########################################################
variable "postgresql_version" {
  description = "(required) postgresql version"
  type        = string
}

variable "psql_admin_name" {
  description = "(required) primary administrator username for the server / (possible) 1 ~ 63 characters and numbers"
  type        = string
}

variable "psql_compute_tier_size" {
  description = "(required) The computer tier and size for the server. the name follow the tier + name pattern. (e.g. B_Standard_B1ms, GP_Standard_D2s_v3, MO_Standard_E4s_v3)."
  type        = string
}

variable "psql_storage_size" {
  description = "(required) The max storage(in MB) allowed for the server."
  type        = number
  validation {
    condition = contains([
      32768, 65536, 131072, 262144, 524288, 1048576, 2097152, 4194304, 8388608, 16777216, 33554432
    ], var.psql_storage_size)
    error_message = "Possible values are '32768', '65536', '131072', '262144', '524288', '1048576', '2097152', '4194304', '8388608', '16777216', '33554432'."
  }
}

variable "psql_availability_zone" {
  description = "(required) The availability zone of the server."
  type        = number
  validation {
    condition     = contains([1, 2, 3], var.psql_availability_zone)
    error_message = "Possible values are '1', '2' and '3'."
  }
}

variable "psql_tags" {
  description = "(optional) Some useful information"
  type        = map(any)
  default     = {}
}

variable "psql_configuration_parameters" {
  description = "(optional) Specifies the server's configuration. The parameter name and value must be paired."
  type        = map(object({
    parameter_name = string
    value          = string
  }))
  default = {}
}