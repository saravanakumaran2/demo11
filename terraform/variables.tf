variable "public_key" {
  description = "Public key content from GitHub Secrets"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "aws_region" {
  default = "ca-central-1"
}
