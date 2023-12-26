resource "azurerm_resource_group" "linux-vm-rg" {
  name     = "${var.prefix}-rg"
  location = "West Europe"
}

resource "azurerm_virtual_network" "linux-vm-vn" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.linux-vm-rg.location
  resource_group_name = azurerm_resource_group.linux-vm-rg.name
}

resource "azurerm_subnet" "linux-vm-subnet" {
  name                 = "internal-subnet"
  resource_group_name  = azurerm_resource_group.linux-vm-rg.name
  virtual_network_name = azurerm_virtual_network.linux-vm-vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "linux-vm-nic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.linux-vm-rg.location
  resource_group_name = azurerm_resource_group.linux-vm-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.linux-vm-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux-vm" {
  name                = "${var.prefix}-instance"
  resource_group_name = azurerm_resource_group.linux-vm-rg.name
  location            = azurerm_resource_group.linux-vm-rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.linux-vm-nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.az_vm_publisher
    offer     = var.az_vm_offer
    sku       = var.az_vm_sku
    version   = var.az_vm_version
  }
}