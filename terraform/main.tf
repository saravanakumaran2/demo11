terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

data "aws_vpc" "default" {
  default = true
}
provider "aws" {
  region = var.aws_region
}

data "aws_key_pair" "existing" {
  key_name = var.key_name
}

resource "aws_security_group" "develop_node" {
  name   = "develop_node"
  vpc_id = data.aws_vpc.default.id

  lifecycle {
    create_before_destroy = true
  }

ingress {
  description = "Allow all traffic"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"      
  cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "develop_node" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.existing.key_name
  vpc_security_group_ids = [aws_security_group.develop_node.id]

  tags = {
    Name = "develop_node"
  }
}

resource "aws_eip_association" "develop_attach" {
  instance_id   = aws_instance.develop_node.id
  allocation_id = "eipalloc-0ae353f17264eefad"  
}
