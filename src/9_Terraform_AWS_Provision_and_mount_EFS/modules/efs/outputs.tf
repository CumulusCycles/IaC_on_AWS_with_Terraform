output "cc-efs-mount-target-dns-names" {
  description = "EFS Mount Target DNS"
  value       = aws_efs_mount_target.cc-efs-mount-targets[*].dns_name
}
