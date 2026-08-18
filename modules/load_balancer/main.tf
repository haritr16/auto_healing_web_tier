resource "azurerm_public_ip" "lb" {
  name                = "${var.name_prefix}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"

  tags = var.tags
}

resource "azurerm_lb" "main" {
  name                = "${var.name_prefix}-lb"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "public"
    public_ip_address_id = azurerm_public_ip.lb.id
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "web" {
  name            = "${var.name_prefix}-backend"
  loadbalancer_id = azurerm_lb.main.id
}

# Health Probe checking port 80
resource "azurerm_lb_probe" "web" {
  name            = "${var.name_prefix}-health"
  loadbalancer_id = azurerm_lb.main.id

  protocol            = "Http"
  port                = 80
  request_path        = var.health_probe_path
  interval_in_seconds = var.health_probe_interval
  number_of_probes    = var.health_probe_unhealthy_threshold
}

# Rule to route port 80 traffic to the backend pool
resource "azurerm_lb_rule" "http" {
  name            = "${var.name_prefix}-http"
  loadbalancer_id = azurerm_lb.main.id

  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "public"

  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.web.id
  ]

  probe_id = azurerm_lb_probe.web.id
}