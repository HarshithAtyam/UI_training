# Service principle variables

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
  description = "Admin email to be added to the workspace."
  type        = string
}
