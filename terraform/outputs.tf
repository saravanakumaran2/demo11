output "public_ip" {
  value = aws_instance.prod_node.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/democentralcanada.pem ubuntu@${aws_instance.prod_node.public_ip}"
}
