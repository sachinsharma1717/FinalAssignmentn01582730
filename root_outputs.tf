output "resource_group_name" {
  value = module.rgroup.resource_group_name
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "log_analytics_workspace_name" {
  value = module.common.log_analytics_workspace_name
}

output "recovery_services_vault_name" {
  value = module.common.recovery_services_vault_name
}

output "storage_account_name" {
  value = module.common.storage_account_name
}

output "linux_vm_hostnames" {
  value = module.linux_vms.vm_hostnames
}

output "linux_vm_domain_names" {
  value = module.linux_vms.vm_domain_names
}

output "linux_vm_private_ips" {
  value = module.linux_vms.vm_private_ips
}

output "linux_vm_public_ips" {
  value = module.linux_vms.vm_public_ips
}

output "windows_vm_hostnames" {
  value = module.windows_vms.windows_vm_hostnames
}

output "windows_vm_domain_names" {
  value = module.windows_vms.windows_vm_domain_names
}

output "windows_vm_private_ips" {
  value = module.windows_vms.windows_vm_private_ips
}

output "windows_vm_public_ips" {
  value = module.windows_vms.windows_vm_public_ips
}

output "load_balancer_name" {
  value = module.loadbalancer.load_balancer_name
}

output "database_name" {
  value = module.database.database_instance_name
}