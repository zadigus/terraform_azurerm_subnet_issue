module "resource_group" {
  source              = "./resource-group"
  group_prefix        = replace(join("-", [var.project_name, var.jira_project_id]), "/", "")
  location            = var.location
  resource_group_tags = merge(local.tags, var.resource_group_tags)
}

module "nsg" {
  depends_on = [module.resource_group]
  source     = "./nsg"

  name_prefix         = local.resource_prefix
  name_suffix         = local.resource_suffix
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  tags                = local.tags
}

module "vnets" {
  depends_on = [module.resource_group, module.nsg]
  source     = "./vnets"

  location              = var.location
  resource_group_name   = module.resource_group.resource_group_name
  private_subnet_nsg_id = module.nsg.private_subnet_nsg_id
  tags                  = local.tags
}

module "storage_accounts" {
  depends_on = [module.resource_group, module.vnets]
  source     = "./storage-accounts"

  resource_group_name = module.resource_group.resource_group_name
  name_prefix         = local.resource_prefix
  name_suffix         = local.resource_suffix
  location            = var.location
  account_tier        = var.storage_acc_account_tier
  replication_type    = var.storage_acc_replication_type
  tags                = merge(local.tags, var.storage_acc_tags)
  aks_subnet_ids      = [module.vnets.aks_snet_id]
  allowed_ips         = [var.teamcity_agent_ip]
}