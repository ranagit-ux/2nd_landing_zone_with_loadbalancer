resource "azurerm_resource_group" "vision2" {
  for_each = var.rg

  name     = each.value.name
  location = each.value.location

}
