locals {
  vars = read_terragrunt_config(find_in_parent_folders("global.hcl"))
  subscription_id   = local.vars.locals.subscription_id
  tenant_id   = local.vars.locals.tenant_id
  resource_group = local.vars.locals.resource_group
  backend_name = local.vars.locals.backend_name
}
# Generate Azure providers
generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_providers {
        azurerm = {
          source  = "hashicorp/azurerm"
          version = "4.4.0"

        }
      }
    }

    provider "azurerm" {
        features {}
        subscription_id = "${local.subscription_id}"
        tenant_id = "${local.tenant_id}"
    }
EOF
}

remote_state {
    // backend = "azurerm"
    // config = {
    //   subscription_id = "${local.subscription_id}"
    //   key = "terraform.tfstate"
    //   resource_group_name = "${local.resource_group}"
    //   storage_account_name = "${local.backend_name}"
    //   container_name = "tfstates"
    // }
    // generate = {
    //     path      = "backend.tf"
    //     if_exists = "overwrite_terragrunt"
    // }
    backend = "local"
    generate = {
      path      = "backend.tf"
      if_exists = "overwrite_terragrunt"
    }

    config = {
      path = "${path_relative_to_include()}/terraform.tfstate"
    }
}
