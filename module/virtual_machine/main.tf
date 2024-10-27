resource "azurerm_network_interface" "nic" {
for_each = var.vm
  name                = each.value.namenic
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    
    name                          = each.value.ipnicname
    subnet_id                     =data.azurerm_subnet.subnetdata[each.key].id
    private_ip_address_allocation =each.value.private_ip_address_allocation
  }

}
resource "azurerm_linux_virtual_machine" "virtualmachine" {
for_each = var.vm
    name = each.value.vmname
    location = each.value.location
    resource_group_name = each.value.resource_group_name
    admin_username = azurerm_key_vault_secret.username[each.key].value
    admin_password = azurerm_key_vault_secret.password[each.key].value
    disable_password_authentication=false
    network_interface_ids =[ azurerm_network_interface.nic[each.key].id]
    size = each.value.size
    os_disk {
      storage_account_type = each.value.storage_account_type
      caching = each.value.caching
    }
   source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
}
}

resource "azurerm_key_vault_secret" "username" {
  for_each     = var.vm
  name         = "${each.key}-username"
  value        = each.value.username
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}


resource "random_password" "password" {
  for_each         = var.vm
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "password" {
  for_each     = random_password.password
  name         = "${each.key}-password"
  value        = each.value.result 
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}