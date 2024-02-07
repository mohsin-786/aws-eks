resource "aws_eks_fargate_profile" "fargate-prof-1" {
  cluster_name           = aws_eks_cluster.sin-eks.name
  fargate_profile_name   = "kube-system"
  pod_execution_role_arn = aws_iam_role.eks-fargate.arn
  subnet_ids             = [aws_subnet.privnet-1.id, aws_subnet.privnet-2.id]

  selector {
    namespace = "kube-system"
  }
}

resource "aws_eks_fargate_profile" "fargate-prof-2" {
  cluster_name           = aws_eks_cluster.sin-eks.name
  fargate_profile_name   = "sinwa"
  pod_execution_role_arn = aws_iam_role.eks-fargate.arn
  subnet_ids             = [aws_subnet.privnet-1.id, aws_subnet.privnet-2.id]

  selector {
    namespace = "sinwa"
  }
}

resource "aws_eks_cluster" "sin-eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks-iam.arn
  vpc_config {
    endpoint_public_access  = true
    endpoint_private_access = false
    public_access_cidrs     = ["0.0.0.0/0"]
    subnet_ids = [
      aws_subnet.pubnet-1.id,
      aws_subnet.pubnet-2.id,
      aws_subnet.privnet-1.id,
      aws_subnet.privnet-2.id
    ]
  }
  depends_on = [aws_iam_role_policy_attachment.eks-role-attach]
}