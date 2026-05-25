# Variables pour le fichiers EKS/main.tf

variable "cluster_name" {
  description = "Nom du cluster EKS"
  type        = string
}

variable "kubernetes_version" {
  description = "version kunernetes"
  type        = string
}

variable "subnet_ids" {
  description = "IDs des subnets publics pour les load balancers"
  type        = list(string)
}

variable "node_sg_id" {
  description = "ID du security group pour les nodes EKS"
  type        = string
}

variable "instance_type" {
  description = "Type d'instance EC2 pour les nodes EKS"
  type        = string
  default     = "t3.small"
}

variable "node_desired_size" {
  description = "Nombre désiré de worker nodes"
  type        = number
}

variable "node_min_size" {
  description = "Nombre minimum de worker nodes"
  type        = number
}

variable "node_max_size" {
  description = "Nombre maximum de worker nodes"
  type        = number
}
