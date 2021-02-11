# Network resource

resource "azurerm_virtual_network" "k8s_net" {
    name                = "k8s-net"
    address_space       = ["10.0.0.0/16"]
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
    address_prefixes       = ["10.0.1.0/24"]

}

# NIC

resource "azurerm_network_interface" "k8s_nic" {
  name                = "k8s-nic"  
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name

    ip_configuration {
      name                           = "k8s-ip-config"
      subnet_id                      = azurerm_subnet.k8s_subnet.id 
      private_ip_address_allocation  = "Static"
      private_ip_address             = "10.0.1.10"
      public_ip_address_id           = azurerm_public_ip.k8s_public_ip.id
  }

    tags = {
        environment = "k8s-prod"
    }

}

# Public IP

resource "azurerm_public_ip" "k8s_public_ip" {
  name                = "k8s-public-ip"
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  allocation_method   = "Static"
  sku                 = "Basic"

    tags = {
        environment = "k8s-prod"
    }

}