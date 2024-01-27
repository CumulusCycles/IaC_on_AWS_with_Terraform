resource "aws_efs_file_system" "cc-efs" {
  creation_token = var.efs-name
  encrypted      = true

  tags = {
    Name = var.efs-name
  }
}

resource "aws_efs_mount_target" "cc-efs-mount-targets" {
  count          = 2
  file_system_id = aws_efs_file_system.cc-efs.id
  subnet_id      = var.subnet_ids[count.index]
}
