variable "location" {
  type    = string
  default = "asia-southeast2-a" # jakarta
}

variable "project_id" {
  type = string
}

variable "node_locations" {
  type = list
}

variable "cluster_name" {
  type = string
}

variable "node_pool_name" {
  type = string
}

variable "node_count" {
  type    = number
  default = 2
}

variable "machine_type" {
  type    = string
  default = "e2-standard-2"
}

variable "max_cpu" {
  type = string
}

variable "max_memory" {
  type = string
}

variable "service_account" {
  type = string
}

variable "network" {
  type    = string
  default = "rte-vpc-1"
}

variable "subnetwork" {
  type    = string
  default = "rte-southeast2-cluster-1"
}
