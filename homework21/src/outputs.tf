output "ec2_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.nginx[*].public_ip
}
