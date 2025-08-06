output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.nodejs_app.id
}

output "instance_public_ip" {
  description = "Elastic IP address"
  value       = aws_eip.ansible.public_ip
}
