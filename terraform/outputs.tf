output "instance_id" {
  description = "The EC2 instance ID"
  value       = aws_instance.nodejs_app.id
}

output "public_ip" {
  description = "The instance's Elastic IP"
  value       = aws_eip.ansible.public_ip
}
