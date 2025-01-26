resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "deployed_key" {
  key_name   = "key_pair"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_key" {
  filename = "${path.cwd}/../ansible/key_pair.pem"
  content  = tls_private_key.ssh_key.private_key_pem
  file_permission = "0400"  # Secure the private key file
}