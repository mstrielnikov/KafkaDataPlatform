# Generate private key
resource "tls_private_key" "private_key_ansible" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Add SSH key pair to AWS
resource "aws_key_pair" "key_pair" {
  key_name   = var.ssh_key_pair_name
  public_key = tls_private_key.private_key_ansible.public_key_openssh

  tags = merge({
    "ssh_key_pair_name" = var.ssh_key_pair_name,
  }, var.default_tags)
}
