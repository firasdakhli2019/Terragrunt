

variable "web_app_name" {
  description = "Name of the web app"
  type        = string
}

variable "location" {
  description = "The region to deploy resources to in Azure"
  type        = string
}

variable "resource_group" {
  description = "Resource group to use"
  type        = string
}

variable "service_plan_id" {
  type= string
  
}