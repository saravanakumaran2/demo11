variable "aws_region" {
  default = "ca-central-1"
}

variable "key_name" {
  description = "The name of the existing EC2 key pair"
  type        = string
}
