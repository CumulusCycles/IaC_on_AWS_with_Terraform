resource "null_resource" "ssh_connection" {
  # SSH into EC2
  connection {
    type        = "ssh"
    user        = var.ssh_connection_user
    private_key = file(var.local_file_name)
    host        = var.public_ip
  }

  # Copy script.sh shell script from local machine to EC2
  provisioner "file" {
    source      = var.ssh_connection_file_source
    destination = var.ssh_connection_file_destination
  }

  # Set permissions and exec the shell script
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /script.sh",
      "sh /tmp/script.sh"
    ]
  }
}