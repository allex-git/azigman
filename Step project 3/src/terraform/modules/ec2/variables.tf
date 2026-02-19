variable "project_tag" { type = string }
variable "ami_id" { type = string }
variable "instance_type_master" { type = string }
variable "instance_type_worker" { type = string }
variable "public_subnet_id" { type = string }
variable "private_subnet_id" { type = string }
variable "sg_master_id" { type = string }
variable "sg_worker_id" { type = string }
variable "common_tags" { type = map(string) }
variable "existing_key_name" {
  description = "Existing AWS key pair name"
  type        = string
}