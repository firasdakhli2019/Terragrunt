terraform {
  source = "../../modules/web_app"
}

include {
  path = find_in_parent_folders() ## is the root where we have terragrunt.hcl that contains azure provider, create the remote state..
}
# include "env" {
#   path           = find_in_parent_folders("input.hcl")
#   expose         = true
#   merge_strategy = "no_merge"
# }
dependency "service_plan" {
  config_path = "../service_plan"
  #mock_outputs_allowed_terraform_commands = ["validate","init","plan"]
  mock_outputs = {
    service_plan_id = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Web/serverFarms/serverFarmValue"
  }

}

locals {
    config_vars = read_terragrunt_config(find_in_parent_folders("inputs.hcl")).inputs.web_app
}
inputs = {
    location = local.config_vars.location
    resource_group = local.config_vars.resource_group
    web_app_name = local.config_vars.web_app_name
    service_plan_id = dependency.service_plan.outputs.service_plan_id

}