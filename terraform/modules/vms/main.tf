# Create VM

data "template_file" "vm_user_data" {
    for_each = local.nodes

    template = file("${path.module}/user_data/${each.key}.cfg")
}

resource "azurerm_linux_virtual_machine" "k8s_vm" {
    for_each = local.nodes

    name                  = "k8s-${each.key}-azure"
    resource_group_name   = azurerm_resource_group.k8s.name
    location              = azurerm_resource_group.k8s.location
    size                  = var.vm_size
    admin_username        = "ansible"
    network_interface_ids = [ azurerm_network_interface.k8s_nic[each.key].id ]
    
    disable_password_authentication = true

    custom_data = base64encode(data.template_file.vm_user_data[each.key].rendered)

    admin_ssh_key {
        username   = "ansible"
        public_key = file("../.ssh_keys/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.storage_account.primary_blob_endpoint
    }

    tags = {
        environment = "k8s-prod"
    }

}