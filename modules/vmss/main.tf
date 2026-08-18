resource "azurerm_linux_virtual_machine_scale_set" "web" {
  name                = "${var.name_prefix}-vmss"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku       = var.vm_size
  instances = var.instance_count

  admin_username = var.admin_username

  upgrade_mode = "Rolling"

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "${var.name_prefix}-nic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id

      load_balancer_backend_address_pool_ids = [
        var.backend_pool_id
      ]
    }
  }

  health_probe_id = var.health_probe_id

  automatic_instance_repair {
    enabled      = true
    action       = "Replace"
    grace_period = var.repair_grace_period
  }

  user_data = base64encode(
    file("${path.root}/cloud-init/nginx.yaml")
  )

  boot_diagnostics {
  }

  tags = var.tags
}