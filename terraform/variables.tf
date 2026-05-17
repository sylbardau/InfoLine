# Variables pour les fichiers terraform

variable "aws_region" {
  description = "Région AWS pour le déploiement"
  type        = string
  default     = "eu-west-3" # Paris
}

variable "vpc_cidr" {
  description = "Plage IP CIDR pour le VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cidr_subnet_dev" {
  description = "CIDR pour le sous-réseau de Dev"
  type        = string
  default     = "10.0.2.0/24"
}

variable "cidr_subnet_prod" {
  description = "CIDR pour le sous-réseau de Prod"
  type        = string
  default     = "10.0.1.0/24"
}
