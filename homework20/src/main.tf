terraform {
  required_version = ">= 1.4.0"

  backend "s3" {
    bucket = "tf-tfstate-danit-11"
    key    = "state/allex-devops/terraform.tfstate"
    region = "eu-central-1"
  }

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
  }
}

resource "aws_vpc" "allex_devops_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    { Name = "allex-devops-hw20-vpc" },
    local.created_tags
  )
}

resource "aws_subnet" "allex_devops_public_subnet" {
  vpc_id                  = aws_vpc.allex_devops_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = merge(
    { Name = "allex-devops-hw20-public-subnet" },
    local.created_tags
  )
}

resource "aws_internet_gateway" "allex_devops_igw" {
  vpc_id = aws_vpc.allex_devops_vpc.id

  tags = merge(
    { Name = "allex-devops-hw20-igw" },
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
    { Name = "allex-devops-hw20-public-rt" },
    local.created_tags
  )
}

resource "aws_route_table_association" "allex_devops_public_assoc" {
  subnet_id      = aws_subnet.allex_devops_public_subnet.id
  route_table_id = aws_route_table.allex_devops_public_rt.id
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id             = aws_vpc.allex_devops_vpc.id
  subnet_id          = aws_subnet.allex_devops_public_subnet.id
  list_of_open_ports = var.list_of_open_ports
  key_name           = var.key_name

  tags = local.created_tags
}
