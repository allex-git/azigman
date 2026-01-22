output "vpc_id" {
  value = aws_vpc.allex_devops_vpc.id
}
output "public_subnet_id" {
  value = aws_subnet.allex_devops_public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.allex_devops_private_subnet.id
}

output "igw_id" {
  value = aws_internet_gateway.allex_devops_igw.id
}

output "public_route_table_id" {
  value = aws_route_table.allex_devops_public_rt.id
}
output "public_ec2_ip" {
  value = aws_instance.allex_devops_public_ec2.public_ip
}

output "private_ec2_ip" {
  value = aws_instance.allex_devops_private_ec2.private_ip
}
