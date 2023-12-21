resource "azurerm_resource_group" "linux-vm-rg" {
  name     = "linux-vm-resources-${terraform.workspace}"
  location = var.location[terraform.workspace]
}

resource "azurerm_virtual_network" "linux-vm-vn" {
  name                = "linux-vm-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.linux-vm-rg.location
  resource_group_name = azurerm_resource_group.linux-vm-rg.name
}

resource "azurerm_subnet" "linux-vm-subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.linux-vm-rg.name
  virtual_network_name = azurerm_virtual_network.linux-vm-vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "linux-vm-nic" {
  name                = "linux-vm-nic"
  location            = azurerm_resource_group.linux-vm-rg.location
  resource_group_name = azurerm_resource_group.linux-vm-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.linux-vm-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux-vm" {
  name                = "linux-vm-instance"
  resource_group_name = azurerm_resource_group.linux-vm-rg.name
  location            = azurerm_resource_group.linux-vm-rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.linux-vm-nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}