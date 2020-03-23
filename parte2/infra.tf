provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  features {}
}
resource "azurerm_resource_group" "test" {
  name     = "RGAzureDemo"
  location = "East US"
  tags = {
    Ambiente = "Desarrollo"
  }
}

resource "azurerm_app_service_plan" "main" {
  name                = "azdemojoyapu-asp"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  sku {
    tier = "Standard"
    size = "B1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "azdemojoyapu-web"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  app_service_plan_id = "${azurerm_app_service_plan.main.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    remote_debugging_enabled = true
    remote_debugging_version = "VS2015"
  }
}
