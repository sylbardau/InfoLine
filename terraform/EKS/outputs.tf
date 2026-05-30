output "cluster_name" {
  description = "Nom du cluster EKS"
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "Endpoint API Kubernetes"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_ca" {
  description = "Certificat CA du cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
  sensitive   = true
}
