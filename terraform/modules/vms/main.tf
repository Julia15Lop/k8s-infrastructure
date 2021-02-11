# Create VM

resource "azurerm_linux_virtual_machine" "k8s_master" {
    name                  = "k8s-master"
    resource_group_name   = var.resource_group_name
    location              = var.location
    size                  = var.vm_size
    admin_username        = "ansible"
    network_interface_ids = [ var.k8s_nic_id ]
    disable_password_authentication = true

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
        storage_account_uri = var.stg_account
    }

    tags = {
        environment = "k8s-prod"
    }

}