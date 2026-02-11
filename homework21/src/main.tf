terraform {
  required_version = ">= 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

locals {
  created_tags = {
    created_by = "Allex DevOps"
    homework   = "HW21"
  }
}

resource "aws_vpc" "allex_devops_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    { Name = "allex-devops-hw21-vpc" },
    local.created_tags
  )
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.allex_devops_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = merge(
    { Name = "allex-devops-hw21-public-subnet" },
    local.created_tags
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.allex_devops_vpc.id

  tags = merge(
    { Name = "allex-devops-hw21-igw" },
    local.created_tags
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.allex_devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    { Name = "allex-devops-hw21-public-rt" },
    local.created_tags
  )
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "nginx_sg" {
  name        = "allex-devops-hw21-nginx-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.allex_devops_vpc.id

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

  tags = local.created_tags
}

resource "aws_instance" "nginx" {
  count         = 2
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = aws_subnet.public.id

  vpc_security_group_ids = [
    aws_security_group.nginx_sg.id
  ]

  tags = merge(
    local.created_tags,
    {
      Name = "allex-devops-hw21-nginx-${count.index + 1}"
    }
  )
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/ansible/inventory.ini"

content = templatefile("${path.module}/inventory.tpl", {
  servers      = aws_instance.nginx[*].public_ip
  ssh_key_path = var.ansible_ssh_key_path
})
}
