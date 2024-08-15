terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01582730"
    storage_account_name = "tfstaten01582730sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}