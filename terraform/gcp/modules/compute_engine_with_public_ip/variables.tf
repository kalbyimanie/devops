variable "instance_name" {
  type    = string
  default = ""
}

variable "machine_type" {
  type    = string
  default = "custom-2-{2*1028}" # 2 cores 2 GiB of mem
}

variable "number_of_instances" {
  type    = number
  default = 3
}

variable "zone" {
  type    = string
  default = "asia-southeast1-a"
}

variable "network_tags" {
  type    = list
  default = ["bastion"]
}


variable "project_id" {
  type    = string
  default = "road-to-expert"

}

# variable "network_name" {
#   type    = string
#   default = "rte-vpc-1"
# }

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

variable "startup_script" {
  type = string
}


variable "extended_disk_size" {
  type = number
}

variable "extended_disk_type" {
  type    = string
  default = "pd-standard"
}

variable "boot_disk_size" {
  type = number
}

variable "image_name" {
  type    = string
  default = "ubuntu-1804-bionic-v20210817"
}

variable "boot_disk_type" {
  type    = string
  default = "pd-standard"
}
