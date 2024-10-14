terraform {
  source = "../../modules/service_plan"
}

include {
  path = find_in_parent_folders() ## is the root where we have terragrunt.hcl that contains azure provider, create the remote state..
}
# include "env" {
#   path           = find_in_parent_folders("input.hcl")
#   expose         = true
#   merge_strategy = "no_merge"
# }
locals {
    config_vars = read_terragrunt_config(find_in_parent_folders("inputs.hcl")).inputs.service_plan
}
inputs = {
    location = local.config_vars.location
    resource_group = local.config_vars.resource_group
    service_plan_name = local.config_vars.service_plan_name

}