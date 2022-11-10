resource "aws_eks_cluster" "cluster-phone-validator" {
    name        = "cluster-phone-validator"
    role_arn    = aws_iam_role.eks_cluster_role.arn
    
    vpc_config  {
        #subnet_ids = data.terraform_remote_state.vpc_jpv.outputs.subnet_ids
       subnet_ids = [aws_subnet.vpc_phonevalidator_public_subnet[0].id, aws_subnet.vpc_phonevalidator_public_subnet[1].id]
    }
}

resource "aws_iam_role" "eks_cluster_role" {
    name = "eks-cluster-role"

    assume_role_policy = <<POLICY
{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "eks.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    POLICY
}

resource "aws_iam_role_policy_attachment" "phone-validator-AmazonEKSClusterPolicy" {
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role        = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "phone-validator-AmazonEKSServicePolicy" {
    policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
    role        = aws_iam_role.eks_cluster_role.name
}