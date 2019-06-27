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
resource "azurerm_container_registry" "acr" {
  name                     = "acreu2${local.proyecto}${local.ambiente}"
  resource_group_name      = "${azurerm_resource_group.rgid.name}"
  location                 = "${azurerm_resource_group.rgid.location}"
  sku                      = "Standard"
  admin_enabled            = true
}
resource "azurerm_kubernetes_cluster" "aksid" {
  name                = "akseu2${local.proyecto}${local.ambiente}"
  location            = "${azurerm_resource_group.rgid.location}"
  resource_group_name = "${azurerm_resource_group.rgid.name}"
  dns_prefix          = "akseu2${local.proyecto}${local.ambiente}"

  agent_pool_profile {
    name            = "default"
    count           = 1
    vm_size         = "Standard_D1_v2"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "${local.client_id}"
    client_secret = "${local.client_secret}"
  }

  tags = {
    Ambiente = "Desarrollo"
  }
}
resource "azurerm_storage_account" "stgid" {
  name                     = "stgeu2${local.proyecto}${local.ambiente}"
  resource_group_name      = "${azurerm_resource_group.rgid.name}"
  location                 = "${azurerm_resource_group.rgid.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    Ambiente = "Desarrollo"
  }
}
