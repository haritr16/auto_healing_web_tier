output "load_balancer_id" {
  value = azurerm_lb.main.id
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.web.id
}

output "health_probe_id" {
  value = azurerm_lb_probe.web.id
}

output "public_ip_address" {
  value = azurerm_public_ip.lb.ip_address
}