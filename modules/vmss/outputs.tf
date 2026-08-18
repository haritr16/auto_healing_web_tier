output "vmss_id" {
  description = "ID of the VM Scale Set."
  value       = azurerm_linux_virtual_machine_scale_set.web.id
}

output "vmss_name" {
  description = "Name of the VM Scale Set."
  value       = azurerm_linux_virtual_machine_scale_set.web.name
}