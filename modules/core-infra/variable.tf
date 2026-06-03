
variable "prefix" {
  type        = string
  description = "Resource name prefix"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev/prod)"

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Environment must be either 'dev' or 'prod'."
  }
}

variable "enable_firewall" {
  type        = bool
  description = "Enable Azure Firewall"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT Gateway"
}

variable "enable_acr" {
  type        = bool
  description = "Enable Azure Container Registry"
}

variable "enable_private_endpoints" {
  type        = bool
  description = "Enable Private Endpoints for resources"
}
variable "enable_jumpbox_public_ip" {
  type        = bool
  description = "Enable Public IP for Jumpbox"
}
variable "enable_bastion" {
  type        = bool
  description = "Enable Bastion Host"
}
variable "acr_sku" {
  type        = string
  description = "SKU for Azure Container Registry (e.g., Basic, Standard, Premium)"
}
variable "ssh_public_key" {
  description = "The path to the SSH public key"
  type        = string
}

locals {
  common_tags = merge(
    var.tags,
    {
      Env = var.environment
    }
  )
}
