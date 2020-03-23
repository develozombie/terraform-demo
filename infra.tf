locals {
  subscription_id= ""
  client_id= ""
  client_secret= ""
  tenant_id= ""
  proyecto= ""
  ambiente= ""
}
provider "azurerm" {
  subscription_id= "${local.subscription_id}"
  client_id = "${local.client_id}"
  client_secret = "${local.client_secret}"
  tenant_id = "${local.tenant_id}"
}
resource "azurerm_resource_group" "rgid" {
  name     = "RGEU2${local.proyecto}${local.ambiente}"
  location = "East US 2"
  tags = {
    Ambiente = "Desarrollo"
  }
}
