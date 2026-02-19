output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "sg_master_id" {
  value = aws_security_group.master.id
}

output "sg_worker_id" {
  value = aws_security_group.worker.id
}
