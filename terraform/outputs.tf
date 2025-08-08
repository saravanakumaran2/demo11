output "public_ip" {
  value = aws_instance.develop_node.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/democentralcanada.pem ubuntu@${aws_instance.develop_node.public_ip}"
}
