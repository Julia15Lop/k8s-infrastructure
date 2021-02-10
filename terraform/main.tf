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

# Module common
module "common" {
    source = "./modules/common"
}

# Module master
module "master" {
    source = "./modules/master"

    resource_group_name = module.common.resource_group_name
}