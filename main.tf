terraform {
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = "~> 1.0"
    }
  }
}

provider "fabric" {
  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id
}

# --- Get Target Capacity ---
data "fabric_capacity" "selected" {
  display_name = var.capacity_name
}

# --- Create Workspace ---
resource "fabric_workspace" "workspace" {
  display_name = var.workspace_name
  description  = "Workspace created automatically via GitHub → Terraform"
  capacity_id  = data.fabric_capacity.selected.id
}

# --- Assign Admin Role using Object ID ---
resource "fabric_workspace_role_assignment" "admin_assignment" {
  workspace_id = fabric_workspace.workspace.id

  principal = {
    id   = var.admin_object_id   # <-- NOW USING OBJECT ID, CORRECT
    type = "User"
  }

  role = "Admin"
}

output "workspace_details" {
  value = {
    id       = fabric_workspace.workspace.id
    name     = fabric_workspace.workspace.display_name
    capacity = var.capacity_name
    admin    = var.admin_object_id
  }
}
