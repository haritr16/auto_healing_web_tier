locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {
    Project     = "auto-healing-web-tier"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Purpose     = "Infrastructure assessment"
  }
}