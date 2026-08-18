variable "project_name" {
  description = "Short project identifier used in resource names."
  type        = string
  default     = "webtier"
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "australiaeast"
}

variable "address_space" {
  description = "Virtual network address space."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Web subnet address prefixes."
  type        = list(string)
  default     = ["10.10.1.0/24"]
}

variable "vm_size" {
  description = "Azure VM size for each VMSS instance."
  type        = string
  default     = "Standard_B1s"
}

variable "instance_count" {
  description = "Number of VMSS instances."
  type        = number
  default     = 2

  validation {
    condition     = var.instance_count >= 2
    error_message = "instance_count must be at least 2."
  }
}

variable "admin_username" {
  description = "Administrator username for Linux VMSS instances."
  type        = string
  default     = "azureadmin"
}

variable "admin_ssh_public_key" {
  description = "SSH public key used to access the Linux VMSS instances. Set this in terraform.tfvars or via TF_VAR_admin_ssh_public_key so the repo remains portable."
  type        = string
}

variable "repair_grace_period" {
  description = "Grace period before automatic instance repair."
  type        = string
  default     = "PT10M"
}