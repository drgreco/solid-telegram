# example for s3 sub-bucket read/write
resource "aws_iam_user" "s3-access" {
    name = "${var.clusterName}-s3-access"
}

resource "aws_iam_user_policy" "s3-access" {
    name = "${var.clusterName}-s3-access"
    user = "${aws_iam_user.s3-access.name}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::some-bucket/${var.clusterName}/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::some-bucket"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_access_key" "s3-access" {
    user = "${aws_iam_user.s3-access.name}"
}


# example for dynamo-access
resource "aws_iam_user" "dynamo-access" {
    name = "${var.clusterName}-dynamo-access"
}
resource "aws_iam_user_policy" "dynamo-access" {
    name = "${var.clusterName}-dynamo-access"
    user = "${aws_iam_user.dynamo-access.name}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [

        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "dynamodb:GetRecords",
                "dynamodb:PutItem",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:UpdateItem",
                "dynamodb:CreateTable"
            ],
            "Resource": [
                "arn:aws:dynamodb:us-east-1:646216580765:table/${var.clusterName}-dynamo-access"
            ]
        }      
    ]
}
EOF
}

resource "aws_iam_access_key" "dynamo-access" {
    user = "${aws_iam_user.dynamo-access.name}"
}
