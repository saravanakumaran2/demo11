terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

########################################
# Look up the default VPC in the region
########################################
data "aws_vpc" "default" {
  default = true
}

########################################
# Lookup Existing AWS Key Pair (Optional)
########################################
data "aws_key_pair" "existing" {
  key_name = var.key_name
}

########################################
# Security Group for SSH & HTTP
########################################
resource "aws_security_group" "node_sg" {
  name   = "node_sg1"
  vpc_id = data.aws_vpc.default.id

  lifecycle {
    create_before_destroy = true
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

########################################
# Ubuntu AMI
########################################
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

########################################
# EC2 Instance using existing key
########################################
resource "aws_instance" "nodejs_app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.node_sg.id]

  tags = {
    Name = "nodejs-app"
  }
}

########################################
# Elastic IP Association
########################################
resource "aws_eip_association" "ansible_attach" {
  instance_id   = aws_instance.nodejs_app.id
  allocation_id = "eipalloc-0ae353f17264eefad"  # ✅ Your existing static EIP
}
