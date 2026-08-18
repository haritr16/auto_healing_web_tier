resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg"
  location = var.location

  tags = local.common_tags
}

module "network" {
  source = "./modules/network"

  name_prefix             = local.name_prefix
  resource_group_name     = azurerm_resource_group.main.name
  location                = azurerm_resource_group.main.location
  address_space           = var.address_space
  subnet_address_prefixes = var.subnet_address_prefixes

  tags = local.common_tags
}

module "load_balancer" {
  source = "./modules/load_balancer"

  name_prefix         = local.name_prefix
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  tags = local.common_tags
}

module "vmss" {
  source = "./modules/vmss"

  name_prefix         = local.name_prefix
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  subnet_id       = module.network.subnet_id
  backend_pool_id = module.load_balancer.backend_pool_id
  health_probe_id = module.load_balancer.health_probe_id

  admin_username       = var.admin_username
  admin_ssh_public_key = var.admin_ssh_public_key
  vm_size              = var.vm_size
  instance_count       = var.instance_count

  repair_grace_period = var.repair_grace_period

  tags = local.common_tags
}