kops + terraform
================
Using terraform to leverage all of the AWS platform when using kops
---------------------------------------------------------------

[kops](https://github.com/kubernetes/kops)
[terraform](https://www.terraform.io/)

Both kops and terraform have a little setup. kops needs an environment variable, and terraform needs to know about your aws credentials.

### Creating your cluster

Create your cluster with kops as normal
```kops create cluster --zones us-east-1a solid-telegram.api.zvelo.com```
 * list clusters with: kops get cluster
 * edit this cluster with: kops edit cluster solid-telegram.api.zvelo.com
 * edit your node instance group: kops edit ig --name=solid-telegram.api.zvelo.com nodes
 * edit your master instance group: kops edit ig --name=solid-telegram.api.zvelo.com master-us-east-1a


`kops update cluster --name solid-telegram.api.zvelo.com --yes`

Wait for the cluster to become available
`kubectl get cluster-info` will return when its ready


log into aws console (or use aws-cli), find the following information
- for redis:
 - Subnet ID
 - Node Security Group ID
- for cluster-autoscaler
 - Node Role Name
   - nodes.solid-telegram.api.zvelo.com

Edit `main.tf` with the values above

```
cd terraform
terraform plan
terraform apply
cd ..
vim autoscale/autoscale.yaml
kubectl apply -f autoscale
```

### Modifying the cluster

Make the appropriate changes with kops or terraform, and apply as per that tool. Changes are tracked independently, as long as your subnet, security groups, and node role name stay the same. 

### Deleting the cluster

first, we need to delete with terraform

```
cd terraform
terraform destroy
```

then, delete with kops


```kops delete --name solid-telegram.api.zvelo.com```
