####################
# Kinesis Stream
####################
resource "aws_kinesis_firehose_delivery_stream" "dataset_history" {
    name = "${var.clusterName}-dataset-history"
    destination = "s3"
    s3_configuration {
        prefix = "${var.clusterName}/internal/"
        buffer_size = "100"
        buffer_interval = "300"
        compression_format = "GZIP"
        role_arn = "${aws_iam_role.dataset_history.arn}" 
        bucket_arn = "arn:aws:s3:::dataset-history" 
    }
}

resource "aws_iam_role" "dataset_history" {
    name = "${var.clusterName}-dataset_history"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "dataset_history" {
    name = "${var.clusterName}_dataset_history"
    role = "${aws_iam_role.dataset_history.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:AbortMultipartUpload",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws:s3:::dataset-history/${var.clusterName}",
        "arn:aws:s3:::dataset-history/${var.clusterName}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:us-east-1:646216580765:log-group:/aws/kinesisfirehose/${var.clusterName}-dataset-history:log-stream:*"
      ]
    }
  ]
}
EOF
}
