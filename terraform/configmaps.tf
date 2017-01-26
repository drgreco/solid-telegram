##############
# general env
##############
data "template_file" "env" {
    template = "${file("configmaps/env.tmpl")}"
  
    vars {
		clusterName = "${var.clusterName}"
		region = "${var.region}"
		redisAddress = "${aws_elasticache_replication_group.redis.primary_endpoint_address}:6379"
    }
}

output "env" {
    value = "${data.template_file.env.rendered}"
}

############
# aws users
############
data "template_file" "aws-users" {
    template = "${file("configmaps/aws-users.tmpl")}"

    vars {
        s3-access-access = "${base64encode(aws_iam_access_key.s3-access.id)}"
        s3-access-secret = "${base64encode(aws_iam_access_key.s3-access.secret)}"
        dynamo-access-access = "${base64encode(aws_iam_access_key.dynamo-access.id)}"
        dynamo-access-secret = "${base64encode(aws_iam_access_key.dynamo-access.secret)}"
    }
}

output "aws-users" {
    value = "${data.template_file.aws-users.rendered}"
}

