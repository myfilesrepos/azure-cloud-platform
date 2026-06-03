environment = "prod"
location    = "germanywestcentral"
prefix      = "platform"
tags = {
  Env        = "prod"
  Owner      = "platform-team"
  CostCenter = "shared"
}
allowed_locations = ["germanywestcentral", "germanynorth"]

# az account management-group list --query "[?displayName=='Tenant Root Group'].id" -o tsv
tenant_root_management_group_id = "YOUR_TENANT_ROOT_MG_ID"