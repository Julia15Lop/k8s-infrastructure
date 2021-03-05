# Network resource

resource "azurerm_virtual_network" "k8s_net" {
    name                = "k8s-net"
    address_space       = ["172.16.0.0/16"]
    location            = azurerm_resource_group.k8s.location
    resource_group_name = azurerm_resource_group.k8s.name

    tags = {
        environment = "k8s-prod"
    }
}

# Subnet resource

resource "azurerm_subnet" "k8s_subnet" {
    name                   = "k8s-subnet"
    resource_group_name    = azurerm_resource_group.k8s.name
    virtual_network_name   = azurerm_virtual_network.k8s_net.name
    address_prefixes       = ["172.16.1.0/24"]

}

# NIC

resource "azurerm_network_interface" "k8s_nic" {
  for_each = local.nodes

  name                = "k8s-${each.key}-nic"  
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name

    ip_configuration {
      name                           = "k8s-${each.key}-ip-config"
      subnet_id                      = azurerm_subnet.k8s_subnet.id 
      private_ip_address_allocation  = "Static"
      private_ip_address             = each.value
      public_ip_address_id           = azurerm_public_ip.k8s_public_ip[each.key].id
    }

    tags = {
      environment = "k8s-prod"
    }

}

# Public IP

resource "azurerm_public_ip" "k8s_public_ip" {
  for_each = local.nodes

  name                = "k8s-${each.key}-ip"
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  allocation_method   = "Static"
  sku                 = "Basic"

    tags = {
        environment = "k8s-prod"
    }

}