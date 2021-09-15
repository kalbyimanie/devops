variable "instance_name" {
  type    = string
  default = ""
}

variable "machine_type" {
  type    = string
  default = "custom-2-{2*1028}" # 2 cores 2 GiB of mem
}

variable "zone" {
  type    = string
  default = "asia-southeast1-a"
}

variable "network_tags" {
  type    = list
  default = ["bastion"]
}

variable "service_account_email" {
  type = string
}

variable "project_id" {
  type    = string
  default = "road-to-expert"

}

variable "network_name" {
  type    = string
  default = "rte-vpc-1"
}

variable "subnetwork_name" {
  type    = string
  default = ""
}

variable "subnetwork_project" {
  type    = string
  default = ""
}

variable "network_tier" {
  type    = string
  default = "STANDARD"
}

variable "labels" {
  type = map
}

variable "ssh_user" {
  type = string
}

variable "path_ssh_pubkey" {
  type = string
}
