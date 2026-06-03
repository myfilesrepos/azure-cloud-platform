resource "azurerm_management_group_subscription_association" "prod" {
  subscription_id     = data.azurerm_subscription.current.id
  management_group_id = azurerm_management_group.prod.id
}

data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}
