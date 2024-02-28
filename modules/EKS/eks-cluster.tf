resource "aws_eks_cluster" "my-eks-cluster" {
  name     = "${terraform.workspace}-eks-cluster"
  role_arn = aws_iam_role.eks-cluster-role.arn

  vpc_config {
    subnet_ids = [var.subnet_ids[2], var.subnet_ids[3]]
  }

  depends_on = [
    aws_iam_role.eks-cluster-role,
    aws_iam_role_policy_attachment.AmazonEksClusterPolicy
  ]
}

resource "aws_eks_node_group" "my-node-group" {
  cluster_name    = aws_eks_cluster.my-eks-cluster.name
  node_group_name = "${terraform.workspace}-node-group"
  node_role_arn   = aws_iam_role.eks-worker-node-role.arn

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = ["t2.medium"]

  remote_access {
    ec2_ssh_key               = "webapp"
    source_security_group_ids = [var.security_group_id]
  }

  subnet_ids = [var.subnet_ids[0], var.subnet_ids[1]]

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}