# Security Group

resource "azurerm_network_security_group" "k8s_sec_group" {
    for_each = local.nodes

    name                = "k8s-${each.key}-sec-group"
    location            = azurerm_resource_group.k8s.location
    resource_group_name = azurerm_resource_group.k8s.name

    tags = {
        environment = "k8s-prod"
    }
}

# Common Security Rules
resource "azurerm_network_security_rule" "commo-rules" {
    for_each = local.nodes

    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name         = azurerm_resource_group.k8s.name
    network_security_group_name = azurerm_network_security_group.k8s_sec_group[each.key].name
}

# Add Master Security rules
resource "azurerm_network_security_rule" "tcp-master" {
    count = length(local.master_ports)

    name                       = "TCP-${count.index}"
    priority                   = 1001 + (count.index + 1)
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = element(local.master_ports, count.index)
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name         = azurerm_resource_group.k8s.name
    network_security_group_name = "k8s-master-nfs-sec-group"
}

# Add Worker security rules
resource "azurerm_network_security_rule" "tcp-workers" {
    count = length(local.worker_ports)

    name                       = "TCP-${count.index}"
    priority                   = 1001 + (count.index + 1)
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = element(local.worker_ports, count.index)
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name         = azurerm_resource_group.k8s.name
    network_security_group_name = "k8s-worker01-sec-group"
}

# Security Group network interface

resource "azurerm_network_interface_security_group_association" "k8s_sec_association" {
    for_each = local.nodes
    
    network_interface_id      = azurerm_network_interface.k8s_nic[each.key].id
    network_security_group_id = azurerm_network_security_group.k8s_sec_group[each.key].id
}
