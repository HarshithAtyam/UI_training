terraform {
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = "~> 1.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47"
    }
  }
}

provider "fabric" {
  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id
}

provider "azuread" {
  tenant_id     = var.tenant_id
  client_id     = var.client_id
  client_secret = var.client_secret
}


# --- Get the capacity from the mapped name ---
data "fabric_capacity" "selected" {
  display_name = var.capacity_name
}

# --- Create the Fabric Workspace ---
resource "fabric_workspace" "workspace" {
  display_name = var.workspace_name
  description  = "Workspace created automatically via GitHub → Terraform pipeline"
  capacity_id  = data.fabric_capacity.selected.id
}

# --- Assign Admin Role to User ---
resource "fabric_workspace_role_assignment" "add_admin" {
  workspace_id = fabric_workspace.workspace.id

  principal = {
    id   = local.admin_object_id
    type = "User"
  }

  role = "Admin"
}

# --- Outputs ---
output "workspace_details" {
  value = {
    id       = fabric_workspace.workspace.id
    name     = fabric_workspace.workspace.display_name
    capacity = var.capacity_name
    admin    = var.admin_email
  }
}
