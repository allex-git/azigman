#terraform {
#  required_version = ">= 1.5.0"
#  required_providers {
#    aws = {
#      source  = "hashicorp/aws"
#      version = "~> 5.0"
#    }
#  }
#}

provider "aws" {
  region = var.region
}

data "aws_ami" "ubuntu_24_04" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

locals {
  common_tags = {
    created_by = "Allex DevOps"
    project    = var.project_tag
  }
}

module "vpc" {
  source              = "./modules/vpc"
  project_tag         = var.project_tag
  vpc_cidr            = var.vpc_cidr
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  az                  = var.az
  my_ip_cidr          = var.my_ip_cidr
  common_tags         = local.common_tags
}

module "ec2" {
  source               = "./modules/ec2"
  project_tag          = var.project_tag
  ami_id               = data.aws_ami.ubuntu_24_04.id
  instance_type_master = var.instance_type_master
  instance_type_worker = var.instance_type_worker
  public_subnet_id     = module.vpc.public_subnet_id
  private_subnet_id    = module.vpc.private_subnet_id
  sg_master_id         = module.vpc.sg_master_id
  sg_worker_id         = module.vpc.sg_worker_id
  common_tags          = local.common_tags
  existing_key_name    = "AllexDevOpsKeySSH"
}
