locals {
  name_prefix = var.project_name

  common_tags = {
    Project     = "auto-healing-web-tier"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "Auto-healing Web tier Infrastructure"
  }
}