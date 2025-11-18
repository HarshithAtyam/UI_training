# Service principal variables
variable "tenant_id" {
  description = "Azure Tenant ID."
  type        = string
  sensitive   = true
}

variable "client_id" {
  description = "Service Principal Client ID."
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Service Principal Client Secret."
  type        = string
  sensitive   = true
}

# Workspace & Capacity Variables
variable "workspace_name" {
  description = "Name of the workspace to create."
  type        = string
}

variable "capacity_name" {
  description = "Final mapped Fabric capacity name."
  type        = string
}

variable "admin_email" {
  description = "Email of admin to assign to the workspace."
  type        = string
}

# AzureAD lookup for email → object_id
data "azuread_user" "admin" {
  user_principal_name = var.admin_email
}

# Convert lookup to a local variable
locals {
  admin_object_id = data.azuread_user.admin.object_id
}
