module "resource_group" {
  source              = "./resource-group"
  group_prefix        = replace(join("-", [var.project_name, var.jira_project_id]), "/", "")
  location            = var.location
  resource_group_tags = merge(local.tags, var.resource_group_tags)
}

module "vnets" {
  depends_on = [module.resource_group]
  source     = "./vnets"

  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  hub_network         = local.hub_network
  tags                = local.tags
}
