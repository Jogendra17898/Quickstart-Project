#####################################
# PUBLIC IP FOR API GATEWAY
#####################################

resource "azurerm_public_ip" "api_ip" {
  name                = "api-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#####################################
# API NIC
#####################################

resource "azurerm_network_interface" "api_nic" {
  name                = "api-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
    public_ip_address_id          = azurerm_public_ip.api_ip.id
  }
}

#####################################
# ENGINE NIC
#####################################

resource "azurerm_network_interface" "engine_nic" {
  name                = "engine-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.10"
  }
}

#####################################
# PYTHON NIC
#####################################

resource "azurerm_network_interface" "python_nic" {
  name                = "python-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.11"
  }
}

#####################################
# TS NIC
#####################################

resource "azurerm_network_interface" "ts_nic" {
  name                = "ts-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.12"
  }
}

#####################################
# API VM
#####################################

resource "azurerm_linux_virtual_machine" "api_vm" {

  name                = "api-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  size           = "Standard_B1ms"
  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.api_nic.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
  publisher = "Canonical"
  offer     = "ubuntu-24_04-lts"
  sku       = "server-gen1"
  version   = "latest"
}

  custom_data = filebase64("${path.module}/cloud-init/api.sh")
}

#####################################
# ENGINE VM
#####################################

resource "azurerm_linux_virtual_machine" "engine_vm" {

  name                = "engine-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  size           = "Standard_B1ms"
  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.engine_nic.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
  publisher = "Canonical"
  offer     = "ubuntu-24_04-lts"
  sku       = "server-gen1"
  version   = "latest"
}

  custom_data = filebase64("${path.module}/cloud-init/engine.sh")
}

#####################################
# PYTHON VM
#####################################

resource "azurerm_linux_virtual_machine" "python_vm" {

  name                = "python-worker"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  size           = "Standard_B1ms"
  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.python_nic.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
  publisher = "Canonical"
  offer     = "ubuntu-24_04-lts"
  sku       = "server-gen1"
  version   = "latest"
}

  custom_data = filebase64("${path.module}/cloud-init/python-worker.sh")
}

#####################################
# TS VM
#####################################

resource "azurerm_linux_virtual_machine" "ts_vm" {

  name                = "ts-worker"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  size           = "Standard_B1ms"
  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.ts_nic.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

 source_image_reference {
  publisher = "Canonical"
  offer     = "ubuntu-24_04-lts"
  sku       = "server-gen1"
  version   = "latest"
}

  custom_data = filebase64("${path.module}/cloud-init/ts-worker.sh")
}