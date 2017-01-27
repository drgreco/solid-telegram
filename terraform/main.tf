# Generic AWS variables we need
#   create cluster with kops first, then fill these out
variable "availabilityZone"             { default = "us-east-1b" }
variable "clusterSubnet"                { default = "" }
variable "clusterNodeSecurityGroup"     { default = "" }
variable "nodeRole"                     { default = "" }
variable "clusterName"                  { default = "solid-telegram" }
variable "region"                       { default = "us-east-1" }


# things for redis
variable "redisNodeType"                { default = "cache.t2.medium" }
variable "redisNumCacheNodes"           { default = 2 }
variable "redisParameterGroupFamily"    { default = "redis2.8" }


# things for terraform to know about aws
provider aws                            { region = "${var.region}" }
