module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"   # stable + compatible

  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  subnet_ids      = var.private_subnets
  vpc_id          = var.vpc_id

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }
  }
}

