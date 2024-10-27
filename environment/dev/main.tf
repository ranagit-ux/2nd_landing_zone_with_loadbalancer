
module "resource_group" {

    source = "../../module/resource_group"
  rg = var.rg
}
module "virtual_network" {
depends_on = [ module.resource_group,]
    source = "../../module/virtual_network"
    vnet=var.vnet
}
module "storage_account" {
    depends_on = [ module.resource_group]
    source = "../../module/storage_account"
    str=var.str
}

module "key_vault" {
    depends_on = [ module.resource_group]
    source = "../../module/key_vault"
    vm=var.vm
}
module "virtual_machine" {
    depends_on = [module.virtual_network,module.key_vault,module.resource_group]
    source = "../../module/virtual_machine"
    vm=var.vm
  
}
module "bastion" {
    depends_on = [ module.resource_group,module.virtual_network ]
    source = "../../module/bastion"
  
}

module "loadbalancer" {
    depends_on = [ module.resource_group,module.virtual_network,module.virtual_machine]
    source = "../../module/loadbalancer"
    vm=var.vm
  
}