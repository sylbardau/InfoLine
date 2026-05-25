

module "vpc" {
  source = "./VPC"

  # ajout des variables VPC
  aws_region       = var.aws_region
  vpc_cidr         = var.vpc_cidr
  cidr_subnet_loadbalancer_a  = var.cidr_subnet_loadbalancer_a
  cidr_subnet_loadbalancer_b  = var.cidr_subnet_loadbalancer_b
  cidr_subnet_apps_a = var.cidr_subnet_apps_a
  cidr_subnet_apps_b = var.cidr_subnet_apps_b
  ssh_allowed_cidr      = var.ssh_allowed_cidr
}

module "EKS" {
 source = "./EKS"

  # ajout des variables VPC
  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
    subnet_ids = [
    module.vpc.subnet_apps_a_id,
    module.vpc.subnet_apps_b_id
  ]
  node_sg_id = module.vpc.sg_eks_nodes_id
  node_min_size     = var.node_min_size
  node_desired_size = var.node_desired_size
  node_max_size     = var.node_max_size
}



