
resource "azurerm_resource_group" "rg" {
  name      = local.resource_group_name
  location  = var.location
  tags      = var.resource_group_tags
}


/*
resource "azurerm_role_definition" "example" {
  name        = "my-custom-role"
  scope       = azurerm_resource_group.rg.id
  description = "This is a custom role created via Terraform"

  permissions {
    #actions     = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
    actions     = ["*"]
    not_actions = []
  }

  assignable_scopes = [
    azurerm_resource_group.rg.id,
  ]
}

*/