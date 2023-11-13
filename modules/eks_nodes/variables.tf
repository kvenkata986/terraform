variable "node_groups" {
  type = map(object({
    name = string
    #instance_types = list(string)
    desired_size   = number
    max_size       = number
    min_size       = number
    ami_type       = string
    instance_types = list(string)
    #release_version = string
    image_id = string
  }))
  description = "The configuration for the managed node pools."
}

variable "aws_account" {
  type        = string
  description = "name of the aws account"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "endpoint" {
  description = "endpoint name"
  type        = string
}

variable "kube_ca" {
  description = "ca"
  type        = string
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "subnet IDs to use for the EKS workers & control plane"
}
