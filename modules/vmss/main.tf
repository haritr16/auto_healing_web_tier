resource "azurerm_linux_virtual_machine_scale_set" "web" {
  name                = "${var.name_prefix}-vmss"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku       = var.vm_size
  instances = var.instance_count

  admin_username                  = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  upgrade_mode = "Rolling"

  rolling_upgrade_policy {
    max_batch_instance_percent              = 20     # Updates 20% of VMs at a time
    max_unhealthy_instance_percent          = 20     # Maximum allowed failed VMs during update
    max_unhealthy_upgraded_instance_percent = 20     # Maximum allowed failed newly upgraded VMs
    pause_time_between_batches              = "PT0S" # No pause between batches
  }

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