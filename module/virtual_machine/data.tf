data "azurerm_subnet" "subnetdata" {
    for_each = var.vm
  name                 = each.value.sub1name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_key_vault" "kv" {
    for_each = var.vm
  name                = each.value.kvname
  resource_group_name = each.value.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = "visionvirtualnet"
  resource_group_name = "vision2resourcegroup"
}