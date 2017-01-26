# Generic AWS variables we need
#   create cluster with kops first, then fill these out
variable "availabilityZone"             { default = "us-east-1b" }
variable "clusterSubnet"                { default = "subnet-991192a5" }
variable "clusterNodeSecurityGroup"     { default = "sg-846bdbf8" }
variable "nodeRole"                     { default = "nodes.solid-telegram.api.zvelo.com" }
variable "clusterName"                  { default = "solid-telegram" }
variable "region"                       { default = "us-east-1" }


# things for redis
variable "redisNodeType"                { default = "cache.t2.medium" }
variable "redisNumCacheNodes"           { default = 2 }
variable "redisParameterGroupFamily"    { default = "redis2.8" }


# things for terraform to know about aws
provider aws                            { region = "${var.region}" }