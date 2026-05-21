# Variables pour les fichiers terraform

variable "aws_region" {
  description = "Région AWS pour le déploiement"
  type        = string
  default     = "eu-west-3" # Paris
}

variable "cluster_name" {
  description = "Nom du cluster EKS"
  type        = string
  default     = "infoline-eks"
}

variable "vpc_cidr" {
  description = "Plage IP CIDR pour le VPC"
  type        = string
  default     = "10.0.0.0/16"
}

#Subnets publics
variable "cidr_subnet_loadbalancer_a" {
  description = "CIDR subnet public AZ-a"
  type        = string
  default     = "10.0.0.0/24"
}

variable "cidr_subnet_loadbalancer_b" {
  description = "CIDR subnet public AZ-b"
  type        = string
  default     = "10.0.1.0/24"
}

# Subnets privés
variable "cidr_subnet_apps_a" {
  description = "CIDR subnet privé AZ-a (nodes EKS, RDS)"
  type        = string
  default     = "10.0.10.0/24"
}

variable "cidr_subnet_apps_b" {
  description = "CIDR subnet privé AZ-b (haute disponibilité)"
  type        = string
  default     = "10.0.11.0/24"
}

# Sécurité
variable "ssh_allowed_cidr" {
  description = "IP autorisée pour SSH"
  type        = string
  default     = "0.0.0.0/0"  # À restreindre en production !
}
