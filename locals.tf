locals {
  name_prefix = var.project_name

  common_tags = {
    Project   = "auto-healing-web-tier"
    ManagedBy = "Terraform"
    Purpose   = "Auto-healing Web tier Infrastructure"
  }
}