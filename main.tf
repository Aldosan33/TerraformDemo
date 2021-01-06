provider "azurerm" {
  version = "2.5.0"
  features {}
}

resource "azurerm_resource_group" "tf_resource_group" {
  name     = "tfmainrg"
  location = "Brazil South"
}

resource "azurerm_container_group" "tf_container_group" {
  name                = "weatherapi"
  location            = azurerm_resource_group.tf_resource_group.location
  resource_group_name = azurerm_resource_group.tf_resource_group.name
  ip_address_type     = "public"
  dns_name_label      = "aldosan33dns"
  os_type             = "Linux"

  container {
    name   = "weatherapi"
    image  = "aldosan33/weatherapi"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
