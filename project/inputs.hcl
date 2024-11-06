locals {
  common_vars = read_terragrunt_config(find_in_parent_folders("global.hcl"))
}

inputs = {
    service_plan = {
        location = "westeurope"
        resource_group = "Terraform-UpSkilling"
        service_plan_name = "Terraform-UpSkilling-serv-plan"  # should probably use a var
    }
    web_app = {
        location = "westeurope"
        resource_group = "Terraform-UpSkilling"
        web_app_name = "Terraform-UpSkilling-web-app"  # should probably use a var
    }

}