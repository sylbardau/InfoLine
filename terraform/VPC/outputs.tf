output "subnet_apps_a_id" {
  value = aws_subnet.apps_a.id
}

output "subnet_apps_b_id" {
  value = aws_subnet.apps_b.id
}

output "sg_eks_nodes_id" {
  value = aws_security_group.sg_eks_nodes.id
}