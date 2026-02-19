output "master_public_ip" {
  value = aws_instance.master.public_ip
}

output "master_public_dns" {
  value = aws_instance.master.public_dns
}

output "worker_private_ip" {
  value = aws_instance.worker.private_ip
}
