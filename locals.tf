locals {
  aks_name = join("-", [var.project_name, "AKS", "Cluster", var.jira_project_id])
  resource_prefix = lower(replace(var.project_name, "/\\W|_|\\s/", ""))
  resource_suffix = lower(replace(var.jira_project_id, "/\\W|_|\\s/", ""))
  environment = "dev"
  tags = {
    "project" = var.project_name
    "environment" = local.environment
  }
}