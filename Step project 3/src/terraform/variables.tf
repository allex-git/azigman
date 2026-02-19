variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "project_tag" {
  description = "project tag"
  type        = string
  default     = "allex-devops-step-project-3"
}

variable "instance_type_master" {
  description = "EC2 Jenkins master"
  type        = string
  default     = "t3.micro"
}

variable "instance_type_worker" {
  description = "EC2 Jenkins worker"
  type        = string
  default     = "t3.micro"
}

#variable "ssh_public_key" {
#  description = "public SSH key"
#  type        = string
#}

variable "ami_id" {
  description = "ubuntu 24.04 AMI"
  type        = string
  default     = "ami-01f79b1e4a5c64257"
}

variable "vpc_cidr" {
  description = "CIDR VPC"
  type        = string
  default     = "10.0.0.0/23"
}

variable "public_subnet_cidr" {
  description = "public subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "private subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "az" {
  description = "availability zone"
  type        = string
  default     = "eu-central-1a"
}

variable "my_ip_cidr" {
  description = "my ip"
  type        = string
  default     = "0.0.0.0/0"
}
