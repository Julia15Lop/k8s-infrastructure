# Security Group

resource "azurerm_network_security_group" "k8s_sec_group" {
    for_each = local.nodes

    name                = "k8s-${each.key}-sec-group"
    location            = azurerm_resource_group.k8s.location
    resource_group_name = azurerm_resource_group.k8s.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "k8s-prod"
    }
}

# Security Group network interface

resource "azurerm_network_interface_security_group_association" "k8s_sec_association" {
    for_each = local.nodes
    
    network_interface_id      = azurerm_network_interface.k8s_nic[each.key].id
    network_security_group_id = azurerm_network_security_group.k8s_sec_group[each.key].id
}
