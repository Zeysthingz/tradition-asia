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
  source     = "hyperbadger/eks-kubeconfig/aws"
  version    = "1.0.0"
  #  cluster_name = var.eks_cluster_name
  depends_on = [module.eks]
  cluster_id = module.eks.cluster_id
}


resource "local_file" "kubeconfig" {
  content  = module.eks-kubeconfig.kubeconfig
  filename = "kubeconfig_${local.cluster_name}"
}

resource "aws_launch_template" "bottlerocket" {
  name          = "bottlerocket-launch-template"
  image_id      = "ami-034b92b7fa8598c1b"
  instance_type = "t3.micro"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 50 # Or your preferred volume size
      volume_type = "gp3"
    }
  }

  network_interfaces {
    associate_public_ip_address = true
  }

  user_data = base64encode(<<-EOT
[settings.kubernetes]
api-server = ${data.aws_eks_cluster.cluster.endpoint}
cluster-certificate = base64decode(${data.aws_eks_cluster.cluster.certificate_authority.0.data})
cluster-name = "${local.cluster_name}"
EOT
  )
}


#https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest/submodules/eks-managed-node-group
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "18.30.3"
  cluster_name    = "${local.cluster_name}"
  cluster_version = "1.28"
  subnet_ids      = var.vpc_subnet_ids

  vpc_id = var.vpc_id

  eks_managed_node_groups = {
    eks_node_group = {
      desired_size    = 2
      max_size        = 2
      min_size        = 1
      depends_on      = [aws_launch_template.bottlerocket]
      launch_template = aws_launch_template.bottlerocket.id
      instance_types = ["t2.micro"]
    },
    eks_node_group-v2 = {
      desired_size           = 2
      max_size               = 2
      min_size               = 1
      depends_on             = [aws_launch_template.bottlerocket]
      launch_template_id     = aws_launch_template.bottlerocket.id
      create_launch_template = false
      instance_types         = ["t2.micro"]
    },

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