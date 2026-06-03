module "landingzone" {
  source                          = "../../../modules/landingzone"
  environment                     = var.environment
  location                        = var.location
  prefix                          = var.prefix
  tags                            = var.tags
  allowed_locations               = var.allowed_locations
  tenant_root_management_group_id = var.tenant_root_management_group_id
}
