####################
# redis
####################
resource "aws_elasticache_replication_group" "redis" {
    replication_group_id = "${var.clusterName}-redis"
    replication_group_description = "${var.clusterName} standard redis"
    engine_version = "2.8.24"
    node_type = "${var.redisNodeType}"
    number_cache_clusters = "${var.redisNumCacheNodes}"
    port = 6379
    parameter_group_name = "${aws_elasticache_parameter_group.redis.id}"
    subnet_group_name = "${aws_elasticache_subnet_group.redis.id}"
    security_group_ids = ["${var.clusterNodeSecurityGroup}"]
    tags = {
        cluster = "${var.clusterName}"
    }
}

resource "aws_elasticache_subnet_group" "redis" {
    name = "subnet-${var.clusterName}-redis"
    description = "subnet-${var.clusterName}-redis"
    subnet_ids = ["${var.clusterSubnet}"]
}

resource "aws_elasticache_parameter_group" "redis" {
    name = "${var.clusterName}-redis-parameter-group"
    family = "${var.redisParameterGroupFamily}"
    description ="cache parameter group for ${var.clusterName}"

    parameter = {
        name = "appendonly"
        value = "yes"
    }
}
