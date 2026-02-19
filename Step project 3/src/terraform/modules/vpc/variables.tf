variable "project_tag" { type = string }
variable "vpc_cidr" { type = string }
variable "public_subnet_cidr" { type = string }
variable "private_subnet_cidr" { type = string }
variable "az" { type = string }
variable "my_ip_cidr" { type = string }
variable "common_tags" { type = map(string) }
