variable "aws_region" {
  default = "ca-central-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
  default     = ""
}


