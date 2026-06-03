locals {
  is_prod = var.environment == "prod"

  # SYSTEM NODE POOL (AKS CORE)
  system_vm_size = "Standard_D2s_v3"

  system_min_nodes = local.is_prod ? 3 : 1
  system_max_nodes = local.is_prod ? 6 : 3

  # USER NODE POOL (WORKLOADS)
  user_vm_size = "Standard_D2s_v3"

  user_min_nodes = local.is_prod ? 3 : 1
  user_max_nodes = local.is_prod ? 6 : 3

  # DATABASE
  postgres_sku = local.is_prod ? "Standard_D2s_v3" : "Standard_D2s_v3"

  # NETWORKING
  enable_firewall_routing = var.enable_firewall && local.is_prod
}
