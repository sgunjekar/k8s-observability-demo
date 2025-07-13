module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.37.1"

  cluster_name    = "observability-demo"
  cluster_version = "1.29"
  enable_irsa     = true


  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
  eks_managed_node_group_defaults = {
    instance_types = ["t3.medium"]
  }

  eks_managed_node_groups = {
    default = {
      name         = "default"
      min_size     = 1
      max_size     = 2
      desired_size = 2
    }
  }
}




output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}
