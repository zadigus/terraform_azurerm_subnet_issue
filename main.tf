module "resource_group" {
  source              = "./resource-group"
  group_prefix        = replace(join("-", [var.project_name, var.jira_project_id]), "/", "")
  location            = var.location
  resource_group_tags = merge(local.tags, var.resource_group_tags)
}

module "nsg" {
  depends_on = [module.resource_group]
  source     = "./nsg"

  name_prefix                  = local.resource_prefix
  name_suffix                  = local.resource_suffix
  location                     = var.location
  resource_group_name          = module.resource_group.resource_group_name
  tags                         = local.tags
  bastion_subnet_address_space = local.hub_network["bastion"]
}

module "vnets" {
  depends_on = [module.resource_group, module.nsg]
  source     = "./vnets"

  location              = var.location
  resource_group_name   = module.resource_group.resource_group_name
  bastion_subnet_nsg_id = module.nsg.bastion_subnet_nsg_id
  jumpbox_subnet_nsg_id = module.nsg.jumpbox_subnet_nsg_id
  private_subnet_nsg_id = module.nsg.private_subnet_nsg_id
  hub_network           = local.hub_network
  aks_networks          = local.aks_networks
  tags                  = local.tags
}
