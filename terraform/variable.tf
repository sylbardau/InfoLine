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

variable "kubernetes_version" {
  description = "Version de Kubernetes pour le cluster EKS"
  type        = string
  default     = "1.31"
}

variable "node_instance_type" {
  description = "Type d'instance EC2 pour les nodes EKS"
  type        = string
  default     = "t3.small"
}

variable "node_min_size" {
  description = "Nombre minimum de nodes EKS"
  type        = number
  default     = 1
}

variable "node_desired_size" {
  description = "Nombre de nodes EKS souhaité"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Nombre maximum de nodes EKS"
  type        = number
  default     = 3
}
