resource "aws_instance" "master" {
  ami                         = var.ami_id
  instance_type               = var.instance_type_master
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.sg_master_id]
  key_name                    = var.existing_key_name 
  associate_public_ip_address = true

  tags = merge(var.common_tags, {
    Name = "${var.project_tag}-jenkins-master"
    role = "master"
  })
}

resource "aws_instance" "worker" {
  ami                    = var.ami_id
  instance_type          = var.instance_type_worker
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.sg_worker_id]
  key_name               = var.existing_key_name

  tags = merge(var.common_tags, {
    Name = "${var.project_tag}-jenkins-worker"
  })
}
