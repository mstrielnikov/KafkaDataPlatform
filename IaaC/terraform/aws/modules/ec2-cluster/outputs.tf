# Output instances IPs
output "instances_ips_list" {
  value = [for instance in aws_instance.instance : instance.private_ip]
}

# Output instances number
output "instances_number" {
  value = length(aws_instance.instance.*.id)
}
