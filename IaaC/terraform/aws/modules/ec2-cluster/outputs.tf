# Output instances IPs
output "instances_ips_list" {
  value = [for instance_ip in aws_instance.instance : instance.private_ip]
}

# Output instances IDs
output "instances_ids_list" {
  value = [for instance_id in aws_instance.instance : instance.id]
}


# Output instances number
output "instances_number" {
  value = length(aws_instance.instance.*.id)
}
