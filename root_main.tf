module "rgroup" {
  source = "./modules/rgroup-n01582730"

  resource_group_name = "2730-RG"
  location            = "Australia East"
}

module "network" {
  source = "./modules/network-n01582730"
  resource_group_name    = module.rgroup.resource_group_name
  location               = module.rgroup.location
  vnet_name              = "2730-vnet"
  vnet_address_space     = ["10.0.0.0/16"]
  subnet_name            = "2730-subnet"
  subnet_address_space   = "10.0.1.0/24"
  nsg_name               = "2730-nsg"
 
  tags = module.rgroup.tags
}

module "common" {
  source = "./modules/common-n01582730"

  resource_group_name = module.rgroup.resource_group_name
  location            =  module.rgroup.location
  common_tags = module.rgroup.tags
}

module "linux_vms" {
  source              = "./modules/vmlinux-n01582730"
  resource_group_name = module.rgroup.resource_group_name
  location            = module.rgroup.location
  linux_avs           = "linux-avs"
  subnet_id           = module.network.subnet_id
  common_tags         = module.rgroup.tags
  storage_account_uri = module.common.storage_account_blob_endpoint
  pub_key             = "~/.ssh/id_rsa.pub"
}

module "windows_vms" {
  source              = "./modules/vmwindows-n01582730"
  resource_group_name = module.rgroup.resource_group_name
  location            = module.rgroup.location
  subnet_id           = module.network.subnet_id
  storage_account_uri = module.common.storage_account_blob_endpoint
  common_tags         = module.rgroup.tags
}

module "data_disks" {
  source              = "./modules/datadisk-n01582730"
  resource_group_name = module.rgroup.resource_group_name
  location            = module.rgroup.location
 vm_ids = zipmap(
    concat(
      formatlist("linux-vm-%d", range(1, length(module.linux_vms.linux_vm_ids) + 1)),
      formatlist("windows-vm-%d", range(1, length(module.windows_vms.windows_vm_ids) + 1))
    ),
    concat(module.linux_vms.linux_vm_ids, module.windows_vms.windows_vm_ids)
  )
  common_tags         = module.rgroup.tags
}

module "loadbalancer" {
  source              = "./modules/loadbalancer-n01582730"
  resource_group_name = module.rgroup.resource_group_name
  location            = module.rgroup.location
  linux_vm_nic_ids    = module.linux_vms.linux_vm_nic_ids
  linux_vm_nic_ip_config_names = module.linux_vms.network_interface_ip_config_names
  common_tags         = module.rgroup.tags
}

module "database" {
  source              = "./modules/database-n01582730"
  resource_group_name = module.rgroup.resource_group_name
  location            = module.rgroup.location
  common_tags         = module.rgroup.tags
}