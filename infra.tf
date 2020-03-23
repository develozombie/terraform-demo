provider "azurerm" {
}
resource "azurerm_resource_group" "rgid" {
  name     = "RGEU2${local.proyecto}${local.ambiente}"
  location = "East US 2"
  tags = {
    Ambiente = "Desarrollo"
  }
}
