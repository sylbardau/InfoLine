variable "function_name" {
  description = "Nom de la fonction Lambda"
  type        = string
  default     = "infoline-login"
}

variable "aws_region" {
  description = "Région AWS"
  type        = string
}

variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs des subnets privés pour la Lambda"
  type        = list(string)
}
