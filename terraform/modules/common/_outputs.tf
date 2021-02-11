output "resource_group_name" {
  value     = azurerm_resource_group.k8s.name
  sensitive = true
}

output "azurerm_network_interface_id" {
  value = azurerm_network_interface.k8s_nic.id
  sensitive = true
}

output "azurerm_storage_account" {
  value = azurerm_storage_account.storage_account.primary_blob_endpoint
  sensitive = true
}