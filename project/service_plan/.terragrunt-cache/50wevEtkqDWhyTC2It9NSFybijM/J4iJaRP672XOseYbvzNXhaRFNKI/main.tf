resource "azurerm_service_plan" "tfupskilling-service-plan" {
  location            = var.location
  name                = var.service_plan_name
  os_type             = "Linux"
  resource_group_name = var.resource_group
  sku_name            = "B1"
}