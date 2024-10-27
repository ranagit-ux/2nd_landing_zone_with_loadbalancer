
resource "azurerm_public_ip" "lbip" {
  name                = "PublicIPForLB"
  location            = "west us"
  resource_group_name = "vision2resourcegroup"
  allocation_method   = "Static"
}

resource "azurerm_lb" "lbload" {
  name                = "visionLoadBalancer"
  location            = "west us"
  resource_group_name = "vision2resourcegroup"
  sku                 = "Standard"
  sku_tier            = "Regional"
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lbip.id
  }
}
resource "azurerm_lb_backend_address_pool" "backendpool1" {
  loadbalancer_id = azurerm_lb.lbload.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_backend_address_pool_address" "backendnginx01" {
    for_each = var.vm
  name                    = each.value.backendpoolname
  backend_address_pool_id = azurerm_lb_backend_address_pool.backendpool1.id
  virtual_network_id      = data.azurerm_virtual_network.vnet.id
  ip_address              = data.azurerm_network_interface.nicip[each.key].private_ip_address
}

resource "azurerm_lb_probe" "nginxprobe" {
  loadbalancer_id = azurerm_lb.lbload.id
  name            = "http-port"
  port            = 80
}

resource "azurerm_lb_rule" "rule" {
  loadbalancer_id                = azurerm_lb.lbload.id
  name                           = "NginxRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backendpool1.id]
  probe_id                       = azurerm_lb_probe.nginxprobe.id
}
