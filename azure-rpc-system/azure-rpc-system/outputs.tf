output "api_public_ip" {
  value = azurerm_public_ip.api_ip.ip_address
}

output "api_endpoint" {
  value = "http://${azurerm_public_ip.api_ip.ip_address}:8000/inference"
}