#
# permissions to node group 
# for cluster-autoscaler
#
resource "aws_iam_role_policy" "cluster-autoscaler" {
    name = "${var.clusterName}-cluster-autoscaler"
    role = "${var.nodeRole}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup"
       ],
      "Resource": "*"
    }
  ]
}
EOF
}
