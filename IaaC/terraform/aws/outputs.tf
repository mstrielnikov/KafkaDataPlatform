output "ssh_key_pair_ansible_name" {
  value     = aws_key_pair.key_pair_ansible.key_name
}

output "ssh_key_pair_ansible_private_pem" {
  value     = aws_key_pair.key_pair_ansible.private_key_pem
  /* sensitive = true */
}