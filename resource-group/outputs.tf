output "resource_group_name" {
  description = "The name of resource group created."
  value       = azurerm_resource_group.rg.name
}

output "resource_group_id" {
  description = "The id of resource group created."
  value       = azurerm_resource_group.rg.id
}

output "resource_group_location" {
  description = "The location of resource group deployed."
  value       = azurerm_resource_group.rg.location
}
