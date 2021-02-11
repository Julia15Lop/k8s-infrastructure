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

# Module virtual machines
module "vms" {
    source = "./modules/vms"

    resource_group_name = module.common.resource_group_name
    k8s_nic_id          = module.common.azurerm_network_interface_id
    stg_account         = module.common.azurerm_storage_account
}