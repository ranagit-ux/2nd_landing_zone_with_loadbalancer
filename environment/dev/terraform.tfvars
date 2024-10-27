rg = {
  rg1 = {
    name     = "vision2resourcegroup"
    location = "west us"


  }

}

str = {

  str1 = {
    name                     = "visionaccountzone1"
    location                 = "west us"
    resource_group_name      = "vision2resourcegroup"
    account_replication_type = "LRS"
    account_tier             = "Standard"
  }

}


vnet = {
  vnet1 = {
    name                = "visionvirtualnet"
    location            = "west us"
    resource_group_name = "vision2resourcegroup"
    address_space       = ["10.0.0.0/16"]
    subnet = {
      sub1 = {
        name             = "Subnet1"
        address_prefixes = ["10.0.2.0/24"]
      }
      sub2 = {
        name             = "Subnet2"
        address_prefixes = ["10.0.3.0/24"]
      }
    }
  }
}


vm = {
  vm1 = {
    vmname                        = "firstvm"
    namenic                       = "nicvm1"
    location                      = "west us"
    resource_group_name           = "vision2resourcegroup"
    ipnicname                     = "ipnamevm1"
    private_ip_address_allocation = "Dynamic"
    sub1name                      = "Subnet1"
    address_prefixes              = ["10.0.2.0/24"]
    size                          = "Standard_F2"
    storage_account_type          = "Standard_LRS"
    caching                       = "ReadWrite"
    kvname                        = "visionkeyvault123"
    username                      = "vmusername"
    virtual_network_name          = "visionvirtualnet"
    backendpoolname               = "backendnginx01"
  }

  vm2 = {
    vmname                        = "secondvm"
    namenic                       = "nicvm2"
    location                      = "west us"
    resource_group_name           = "vision2resourcegroup"
    ipnicname                     = "ipnamevm2"
    private_ip_address_allocation = "Dynamic"
    sub1name                      = "Subnet2"
    address_prefixes              = ["10.0.3.0/24"]
    size                          = "Standard_F2"
    storage_account_type          = "Standard_LRS"
    caching                       = "ReadWrite"
    kvname                        = "visionkeyvault234"
    username                      = "vmusername"
    virtual_network_name          = "visionvirtualnet"
    backendpoolname               = "backendnginx02"
  }
}


# bsn = {
#   bsn1 = {
#     bastionname          = "AzureBastionSubnet"
#     resource_group_name  = "vision2resourcegroup"
#     virtual_network_name = "visionvirtualnet"
#     address_prefix       = ["10.0.4.0/24"]
#     pipname              = "examplepip"
#     location             = "west us"
#     allocation_method    = "Static"
#     sku                  = "Standard"
#     hostname             = "examplebastion"
#     ipname               = "configuration"
#   }
# }


