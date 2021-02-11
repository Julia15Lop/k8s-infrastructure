# Resource Group

resource "azurerm_resource_group" "k8s" {
    name     = "azure-k8s"
    location = "West Europe"
}

# Storage account

resource "azurerm_storage_account" "storage_account" {
    name                     = "k8sstgaccount" 
    resource_group_name      = azurerm_resource_group.k8s.name
    location                 = azurerm_resource_group.k8s.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = "k8s-prod"
    }

}