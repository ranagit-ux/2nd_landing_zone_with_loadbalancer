data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  for_each                    = var.vm
  name                        = each.value.kvname
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List"
    ]

    secret_permissions = [
      "Get", "Set", "List", "Delete", "Recover", "Backup","Purge"
    ]


  }
}


# resource "azurerm_key_vault_secret" "username" {
#   for_each     = var.vm
#   name         = "${each.key}-username"
#   value        = each.value.username
#   key_vault_id = data.azurerm_key_vault.kv.id
# }


# resource "random_password" "password" {
#   for_each         = var.vm
#   length           = 16
#   special          = true
#   override_special = "!#$%&*()-_=+[]{}<>:?"
# }

# resource "azurerm_key_vault_secret" "password" {
#   for_each     = random_password.password
#   name         = "${each.key}-password"
#   value        = random_password.password[each.key].value
#   key_vault_id = data.azurerm_key_vault.kv.id
# }
