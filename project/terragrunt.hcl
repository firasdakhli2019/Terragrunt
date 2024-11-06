locals {
  vars = read_terragrunt_config(find_in_parent_folders("global.hcl"))
  secrets = read_terragrunt_config(find_in_parent_folders("secrets.hcl"))
  subscription_id   = local.secrets.locals.subscription_id
  tenant_id   = local.secrets.locals.tenant_id
  client_id = local.secrets.locals.client_id
  client_secret = local.secrets.locals.client_secret
  resource_group = local.vars.locals.resource_group
  // backend_name = local.vars.locals.backend_name
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
        client_id = "${local.client_id}"
        client_secret = "${local.client_secret}"
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
