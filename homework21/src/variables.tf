variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key name for EC2"
  type        = string
  default     = "AllexDevOpsKeySSH"
}

variable "ami_id" {
  description = "Ubuntu 24.04 LTS AMI"
  type        = string
  default     = "ami-01f79b1e4a5c64257"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/23"
}

variable "ansible_ssh_key_path" {
  description = "Path to SSH key used by Ansible"
  type        = string
  default     = "/home/tc/AllexDevOpsKeySSH.pem"
}
