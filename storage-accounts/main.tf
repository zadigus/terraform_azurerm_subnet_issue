resource "azurerm_storage_account" "storageAcc" {
  resource_group_name               = var.resource_group_name
  name                              = local.storage_acc_name
  location                          = var.location
  access_tier                       = "Hot"
  # StorageV1 will not work with private endpoints
  account_kind                      = "StorageV2"
  account_replication_type          = var.replication_type
  account_tier                      = var.account_tier
  allow_nested_items_to_be_public   = true
  enable_https_traffic_only         = true
  infrastructure_encryption_enabled = false
  is_hns_enabled                    = false
  min_tls_version                   = "TLS1_2"
  nfsv3_enabled                     = false
  queue_encryption_key_type         = "Service"
  shared_access_key_enabled         = true
  table_encryption_key_type         = "Service"
  tags                              = var.tags
  public_network_access_enabled     = false

  blob_properties {
    change_feed_enabled      = false
    last_access_time_enabled = false
    versioning_enabled       = false

    container_delete_retention_policy {
      days = 7
    }

    delete_retention_policy {
      days = 7
    }
  }

  network_rules {
    bypass = [
      "AzureServices",
    ]
    default_action             = "Allow"
    ip_rules                   = var.allowed_ips
    virtual_network_subnet_ids = var.aks_subnet_ids
  }

  timeouts {}
}