variable "prefix" {
  type        = string
  description = "Resource name prefix"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev/prod)"
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'."
  }
}

variable "monthly_budget" {
  type        = number
  description = "Monthly budget in USD"
}

variable "alert_email" {
  type        = string
  description = "Email address for budget and alert notifications"
}

locals {
  name_prefix = "${var.prefix}-${var.environment}"

  tags = {
    environment = var.environment
    owner       = "platform-team"
    costcenter  = "platform"
  }
}
