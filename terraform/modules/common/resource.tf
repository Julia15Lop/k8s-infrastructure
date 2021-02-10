# Resource Group
resource "azurerm_resource_group" "k8s" {
    name     = "azure-k8s"
    location = "Central US"
}