variable "region" {
  default = "eu-central-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/23"
}

variable "public_subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "ami_id" {
  default = "ami-0387413ed05eb20af"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  default = "AllexDevOpsKeySSH"
}

variable "my_ip" {
  default = "194.183.181.92/32"
}
