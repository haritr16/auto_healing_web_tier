variable "name_prefix" {
  description = "Prefix used for VMSS resource naming."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the VMSS will be created."
  type        = string
}

variable "location" {
  description = "Azure region for the VMSS."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where VMSS network interfaces will be deployed."
  type        = string
}

variable "backend_pool_id" {
  description = "Azure Load Balancer backend pool ID."
  type        = string
}

variable "health_probe_id" {
  description = "Azure Load Balancer health probe ID used for VMSS automatic instance repair."
  type        = string
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
  default     = "Standard_B1s"
}

variable "instance_count" {
  description = "Number of VMSS instances."
  type        = number
  default     = 2

  validation {
    condition     = var.instance_count >= 2
    error_message = "The VMSS must have at least two instances."
  }
}

variable "repair_grace_period" {
  description = "Grace period before automatic instance repair is allowed."
  type        = string
  default     = "PT10M"
}

variable "tags" {
  description = "Tags applied to the VMSS."
  type        = map(string)
}