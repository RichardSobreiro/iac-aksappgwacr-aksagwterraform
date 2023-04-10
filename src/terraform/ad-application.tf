resource "random_uuid" "spr_id" { }

resource "random_password" "spr_password" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "azuread_application" "app" {
  display_name = var.azuread_application
}

resource "azuread_service_principal" "spr" {
  application_id       = azuread_application.app.application_id
}

resource "azuread_service_principal_password" "sps" {
  service_principal_id = azuread_service_principal.spr.id
  //value                = random_password.spr_password.result
  end_date             = "2024-01-15T00:00:00Z" 
}