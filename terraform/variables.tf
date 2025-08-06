variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "ca-central-1"
}

variable "key_name" {
  type        = string
  description = "Name of the AWS key pair"
  default     = "democentralcanda"
}

variable "public_key" {
  type        = string
  description = "Public key material"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}
