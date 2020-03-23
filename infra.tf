provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  features {}
}
resource "azurerm_resource_group" "test" {
  name     = "RGJoyapu"
  location = "East US"
  tags = {
    Ambiente = "Desarrollo"
  }
}
resource "azurerm_storage_account" "stgid" {
  name                     = "stgeu2joyapu"
  resource_group_name      = "${azurerm_resource_group.test.name}"
  location                 = "${azurerm_resource_group.test.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Ambiente = "Desarrollo"
  }
}
