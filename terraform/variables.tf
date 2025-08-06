variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ca-central-1"
}

variable "key_name" {
  description = "Name for AWS key pair"
  type        = string
  default     = "democentralcanada"
}

variable "public_key_path" {
  description = "Path to your public key file"
  type        = string
  default     = "~/.ssh/democentralcanda.pub"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "my_ip_cidr" {
  description = "Your IP for SSH access"
  type        = string
  default     = "0.0.0.0/0"
}
