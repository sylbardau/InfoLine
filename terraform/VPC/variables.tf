# Variables pour le fichiers VPC/main.tf

variable "aws_region" {
  type        = string
  description = "Région AWS"
}

variable "vpc_cidr" {
  type        = string
  description = "Bloc CIDR du VPC"
}

variable "cluster_name" {
  type        = string
  description = "Nom du cluster EKS (pour les tags Kubernetes)"
  default     = "infoline-eks"
}

variable "cidr_subnet_loadbalancer-a" {
  type        = string
  description = "CIDR subnet public AZ-a (Load Balancer, NAT Gateway)"
}

variable "cidr_subnet_loadbalancer-b" {
  type        = string
  description = "CIDR subnet public AZ-b (haute disponibilité)"
}

variable "cidr_subnet_apps-a" {
  type        = string
  description = "CIDR subnet privé AZ-a (nodes EKS, RDS)"
}

variable "cidr_subnet_apps-b" {
  type        = string
  description = "CIDR subnet privé AZ-b (haute disponibilité)"
}

variable "ssh_allowed_cidr" {
  type        = string
  description = "CIDR autorisé pour SSH"
  default     = "0.0.0.0/0"  # À restreindre en production !
}
