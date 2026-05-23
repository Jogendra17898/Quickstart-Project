output "api_public_ip" {
  value = aws_eip.api_eip.public_ip
}

output "api_endpoint" {
  value = "http://${aws_eip.api_eip.public_ip}:8000/inference"
}