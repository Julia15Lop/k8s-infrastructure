terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "=2.46.0"
        }
    }
}

# Configure Azure Provider 
provider "azurerm" {
    features {}
}

