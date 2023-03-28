locals {
  resource_prefix = lower(replace(var.project_name, "/\\W|_|\\s/", ""))
  resource_suffix = lower(replace(var.jira_project_id, "/\\W|_|\\s/", ""))
  environment     = "dev"
  tags            = {
    "project"     = var.project_name
    "environment" = local.environment
  }
  hub_network = {
    "vnet" : "10.0.0.0/20"          # 10.0.0.1 -> 10.0.15.254
    "inbounddns" : "10.0.0.0/24"    # 10.0.0.1 -> 10.0.0.254
    "firewall" : "10.0.1.0/24"      # 10.0.1.1 -> 10.0.1.254
    "vpn_gateway" : "10.0.2.0/24"   # 10.0.2.1 -> 10.0.2.254
    "jumpbox" : "10.0.3.0/24"       # 10.0.3.1 -> 10.0.3.254
    "bastion" : "10.0.4.0/26"       # 10.0.4.1 -> 10.0.4.63
    "resources" : "10.0.5.0/24"     # 10.0.5.1 -> 10.0.5.254
    "database" : "10.0.6.0/24"      # 10.0.6.1 -> 10.0.6.254
  }
}