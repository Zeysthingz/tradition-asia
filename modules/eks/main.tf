provider "aws" {
  region = var.aws_region
}


data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

locals {
  cluster_name = "demo-eks-cluster"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "eks-kubeconfig" {
  source       = "hyperbadger/eks-kubeconfig/aws"
  version      = "1.0.0"
#  cluster_name = var.eks_cluster_name
  depends_on   = [module.eks]
  cluster_id   = module.eks.cluster_id
}


resource "local_file" "kubeconfig" {
  content  = module.eks-kubeconfig.kubeconfig
  filename = "kubeconfig_${local.cluster_name}"
}


#deployment yaml

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.3"
  cluster_name    = "${local.cluster_name}"
  cluster_version = "1.24"
  subnet_ids      = var.vpc_subnet_ids

  vpc_id = var.vpc_id

  eks_managed_node_groups = {
    eks_node_group = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 1
      instance_type    = "t3.micro"
    }
  }
}



resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "nginx-demo-deployment"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}