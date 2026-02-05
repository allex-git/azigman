variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "list_of_open_ports" {
  description = "Ports to open in SG"
  type        = list(number)
  default     = [22, 80]
}

variable "key_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
