#	 VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "vpc-main"
    Environment = "Multi-Env"
  }
}

# 	Passerelle Internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

------------------------------------------------------------------------------------------------------------
# 	Sous-réseau Public
resource "aws_subnet" "loadbalancer_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_subnet_loadbalancer-a
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "subnet-loadbalancer_a"
    Environment = "Production"
    "kubernetes.io/cluster/${var.cluster_name}"   = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }
}

resource "aws_subnet" "loadbalancer_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_subnet_loadbalancer-b
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "subnet-loadbalancer_b"
    Environment = "Production"
    "kubernetes.io/cluster/${var.cluster_name}"   = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }
}
---------------------------------------------------------------------------------------------------------------
#	Sous-réseau privée
resource "aws_subnet" "apps_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_subnet_apps-a
  availability_zone       = "${var.aws_region}a" 
  map_public_ip_on_launch = false

  tags = {
    Name        = "subnet-apps_a"
    Environment = "Production"
    "kubernetes.io/cluster/${var.cluster_name}"   = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

resource "aws_subnet" "apps_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_subnet_apps_b
  availability_zone       = "${var.aws_region}b" 
  map_public_ip_on_launch = false

  tags = {
    Name        = "subnet-apps_b"
    Environment = "Production"
    "kubernetes.io/cluster/${var.cluster_name}"   = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
----------------------------------------------------------------------------------------------------------------

#   NAT GATEWAY
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name    = "nat-eip"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.loadbalancer_a.id

  tags = {
    Name    = "main-nat"
  }

  depends_on = [aws_internet_gateway.igw]
}

-----------------------------------------------------------------------------------------------------------------

# 	Table de routage 
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt-public"
  }
}

# 	Associations des Tables de Routage
resource "aws_route_table_association" "loadbalancer_a" {
  subnet_id      = aws_subnet.loadbalancer_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "loadbalancer_b" {
  subnet_id      = aws_subnet.loadbalancer_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name    = "rt-private"
  }
}

resource "aws_route_table_association" "apps_a" {   
  subnet_id      = aws_subnet.apps_a.id             
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "apps_b" {   
  subnet_id      = aws_subnet.apps_b.id             
  route_table_id = aws_route_table.private.id
}

------------------------------------------------------------------------------------------------------------------------

# 	Groupes de Sécurité (Security Groups)

    # SG Prod : HTTP/HTTPS et SSH
resource "aws_security_group" "sg_prod" {
  name        = "sg_production"
  description = "group de securite production"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    # Port 8080 API Spring Boot lb
  ingress {
    description = "API Spring Boot"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sg-prod"
    Environment = "Production"
  }
}

# Groupes de Sécurité des nodes EKS 
resource "aws_security_group" "sg_eks_nodes" {
  name        = "sg_eks_nodes"
  description = "Groupe de securite pour les nodes EKS"
  vpc_id      = aws_vpc.main.id

  # Communication entre nodes du cluster
  ingress {
    description = "Trafic interne entre nodes"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  # Accès depuis le control plane EKS
  ingress {
    description = "Kubelet depuis le control plane"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sg-eks-nodes"
    Environment = "Production"
  }
}
