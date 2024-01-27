resource "aws_instance" "webserver" {
  count                       = 2
  ami                         = local.ami_id
  instance_type               = local.instance_type
  key_name                    = local.key_name
  subnet_id                   = var.subnet_ids[count.index]
  security_groups             = var.security_group_id
  associate_public_ip_address = true

  tags = {
    Name = "WebServer_${count.index + 1}"
  }

  user_data = templatefile("./modules/webserver/user_data.tfpl", { file_system_path = var.file_system_path, mount_target_dns_name = var.mount_target_dns_names[count.index], server_index = count.index + 1 })
}