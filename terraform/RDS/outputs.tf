output "db_endpoint" {
  description = "Endpoint de connexion PostgreSQL"
  value       = aws_db_instance.main.endpoint
}

output "db_name" {
  description = "Nom de la base de données"
  value       = aws_db_instance.main.db_name
}
