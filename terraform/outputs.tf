# Outputs racine — InfoLine

# --- VPC ---
output "vpc_id" {
  description = "ID du VPC principal"
  value       = module.vpc.vpc_id
}

output "subnet_apps_a_id" {
  description = "ID subnet privé AZ-a"
  value       = module.vpc.subnet_apps_a_id
}

output "subnet_apps_b_id" {
  description = "ID subnet privé AZ-b"
  value       = module.vpc.subnet_apps_b_id
}

# --- EKS ---
output "eks_cluster_name" {
  description = "Nom du cluster EKS"
  value       = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  description = "Endpoint API du cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_ca" {
  description = "Certificat CA du cluster EKS"
  value       = module.eks.cluster_ca
  sensitive   = true
}

# --- Lambda / API Gateway ---
output "api_gateway_url" {
  description = "URL publique de l'API Gateway (endpoint login)"
  value       = module.lambda.api_gateway_url
}

output "lambda_function_name" {
  description = "Nom de la fonction Lambda login"
  value       = module.lambda.lambda_function_name
}

output "dynamodb_table_name" {
  description = "Nom de la table DynamoDB users"
  value       = module.lambda.dynamodb_table_name
}

# --- RDS ---
output "rds_endpoint" {
  description = "Endpoint de la base PostgreSQL"
  value       = module.rds.db_endpoint
}

output "rds_db_name" {
  description = "Nom de la base de données"
  value       = module.rds.db_name
}
