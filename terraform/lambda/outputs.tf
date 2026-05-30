output "lambda_function_name" {
  description = "Nom de la fonction Lambda"
  value       = aws_lambda_function.login.function_name
}

output "lambda_invoke_arn" {
  description = "ARN d'invocation de la Lambda"
  value       = aws_lambda_function.login.invoke_arn
}

output "api_gateway_url" {
  description = "URL de l'API Gateway (endpoint login)"
  value       = "${aws_api_gateway_stage.prod.invoke_url}/login"
}

output "dynamodb_table_name" {
  description = "Nom de la table DynamoDB"
  value       = aws_dynamodb_table.users.name
}
