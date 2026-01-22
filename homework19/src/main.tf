terraform {
  required_version = ">=1.4.0" 
  required_providers { 
    aws = {
      source = "hashicorp/aws" 
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
  }
}

resource "aws_vpc" "allex_devops_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name = "allex-devops-hw19-vpc"
    },
    local.created_tags
  )
}
resource "aws_subnet" "allex_devops_public_subnet" {
  vpc_id                  = aws_vpc.allex_devops_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  
  tags = merge(
    {
      Name = "allex-devops-hw19-public-subnet"
    },
    local.created_tags
  )
}

resource "aws_subnet" "allex_devops_private_subnet" {
  vpc_id     = aws_vpc.allex_devops_vpc.id
  cidr_block = var.private_subnet_cidr

  tags = merge(
    {
      Name = "allex-devops-hw19-private-subnet"
    },
    local.created_tags
  )
}

resource "aws_internet_gateway" "allex_devops_igw" {
  vpc_id = aws_vpc.allex_devops_vpc.id

  tags = merge(
    {
      Name = "allex-devops-hw19-igw"
    },
    local.created_tags
  )
}

resource "aws_route_table" "allex_devops_public_rt" {
  vpc_id = aws_vpc.allex_devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.allex_devops_igw.id
  }

  tags = merge(
    {
      Name = "allex-devops-hw19-public-rt"
    },
    local.created_tags
  )
}

resource "aws_route_table_association" "allex_devops_public_assoc" {
  subnet_id      = aws_subnet.allex_devops_public_subnet.id
  route_table_id = aws_route_table.allex_devops_public_rt.id
}
resource "aws_eip" "allex_devops_nat_eip" {
  domain = "vpc"

  tags = merge(
    { Name = "allex-devops-hw19-nat-eip" },
    local.created_tags
  )
}

resource "aws_nat_gateway" "allex_devops_nat_gw" {
  allocation_id = aws_eip.allex_devops_nat_eip.id
  subnet_id     = aws_subnet.allex_devops_public_subnet.id

  depends_on = [aws_internet_gateway.allex_devops_igw]

  tags = merge(
    { Name = "allex-devops-hw19-nat-gw" },
    local.created_tags
  )
}

resource "aws_route_table" "allex_devops_private_rt" {
  vpc_id = aws_vpc.allex_devops_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.allex_devops_nat_gw.id
  }

  tags = merge(
    { Name = "allex-devops-hw19-private-rt" },
    local.created_tags
  )
}

resource "aws_route_table_association" "allex_devops_private_assoc" {
  subnet_id      = aws_subnet.allex_devops_private_subnet.id
  route_table_id = aws_route_table.allex_devops_private_rt.id
}

resource "aws_security_group" "allex_devops_public_sg" {
  name   = "allex-devops-hw19-sg-public"
  vpc_id = aws_vpc.allex_devops_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    { Name = "allex-devops-hw19-sg-public" },
    local.created_tags
  )
}

resource "aws_security_group" "allex_devops_private_sg" {
  name   = "allex-devops-hw19-sg-private"
  vpc_id = aws_vpc.allex_devops_vpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.allex_devops_public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    { Name = "allex-devops-hw19-sg-private" },
    local.created_tags
  )
}

resource "aws_instance" "allex_devops_public_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.allex_devops_public_subnet.id
  vpc_security_group_ids = [aws_security_group.allex_devops_public_sg.id]
  key_name               = var.key_name

  tags = merge(
    { Name = "allex-devops-hw19-ec2-public" },
    local.created_tags
  )
}

resource "aws_instance" "allex_devops_private_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.allex_devops_private_subnet.id
  vpc_security_group_ids = [aws_security_group.allex_devops_private_sg.id]
  key_name               = var.key_name

  tags = merge(
    { Name = "allex-devops-hw19-ec2-private" },
    local.created_tags
  )
}
