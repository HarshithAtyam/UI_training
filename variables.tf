variable "tenant_id" {
  type        = string
  sensitive   = true
}

variable "client_id" {
  type        = string
  sensitive   = true
}

variable "client_secret" {
  type        = string
  sensitive   = true
}

variable "workspace_name" {
  type = string
}

variable "capacity_name" {
  type = string
}

variable "admin_object_id" {
  type = string
  description = "Azure AD Object ID of user to be assigned as admin"
}
