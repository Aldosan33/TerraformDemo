provider "azurerm" {
  version = "2.5.0"
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf_rg_blobstorage"
    storage_account_name = "tfstorageaccountaldosan"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

variable "imagebuild" {
  type        = string
  default     = ""
  description = "description"
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
    image  = "aldosan33/weatherapi:{var.imagebuild}"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
