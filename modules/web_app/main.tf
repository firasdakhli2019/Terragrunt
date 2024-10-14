
resource "azurerm_linux_web_app" "tfupskilling-service-web-app" {
  client_affinity_enabled   = false
  https_only                = true
  location                  = var.location
  name                      = var.web_app_name
  resource_group_name       = var.resource_group
  service_plan_id           = var.service_plan_id
  virtual_network_subnet_id = null
  identity {
    type = "SystemAssigned"
  }
  site_config {
    always_on                         = true
    ftps_state                        = "FtpsOnly"
    health_check_eviction_time_in_min = 10
    health_check_path                 = "/"
    use_32_bit_worker                 = false
    worker_count                      = 1
    application_stack {
      docker_image_name        = "heartexlabs/label-studio:1.9.1.post0"
      docker_registry_password = null
      docker_registry_url      = "https://docker.io"
      docker_registry_username = null
    }
  }
}
