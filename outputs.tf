output "resource_group_name" {
  description = "Name of the Azure resource group."
  value       = azurerm_resource_group.main.name
}

output "load_balancer_public_ip" {
  description = "Public IP address of the Azure Load Balancer."
  value       = module.load_balancer.public_ip_address
}

output "load_balancer_url" {
  description = "URL of the web application."
  value       = "http://${module.load_balancer.public_ip_address}"
}

output "vmss_name" {
  description = "Name of the VM Scale Set."
  value       = module.vmss.vmss_name
}