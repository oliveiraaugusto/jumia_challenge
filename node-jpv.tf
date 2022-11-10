resource "aws_eks_node_group" "phone-validator-eks-node-group" {
    cluster_name    = aws_eks_cluster.cluster-phone-validator.name
    node_group_name = "phone-validator-node-group"
    node_role_arn   = aws_iam_role.aws_iam_role_jpv.arn
    subnet_ids      = [aws_subnet.vpc_phonevalidator_public_subnet[0].id, aws_subnet.vpc_phonevalidator_public_subnet[1].id]

    scaling_config {
        desired_size    = 1
        max_size        = 3
        min_size        = 1
    }

 update_config {
    max_unavailable = 1
  }


depends_on = [
    aws_iam_role_policy_attachment.aws_iam_role_jpv-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.aws_iam_role_jpv-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.aws_iam_role_jpv-AmazonEC2ContainerRegistryReadOnly,
  ]
}