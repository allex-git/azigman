output "master_public_ip" {
  value = module.ec2.master_public_ip
}

output "worker_private_ip" {
  value = module.ec2.worker_private_ip
}
