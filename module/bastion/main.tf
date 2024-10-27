
resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = "vision2resourcegroup"
  virtual_network_name = "visionvirtualnet"
  address_prefixes      = ["10.0.4.0/24"]
}
resource "azurerm_public_ip" "ip" {
  name                = "examplepip"
  location            = "west us"
  resource_group_name = "vision2resourcegroup"
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "ipconfig" {
  name                = "bastion"
  location            = "west us"
  resource_group_name = "vision2resourcegroup"
  sku                 = "Standard" 

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    # public_ip_address_id = "${azurerm_public_ip.ip.id}"

    public_ip_address_id = azurerm_public_ip.ip.id
  }
}
