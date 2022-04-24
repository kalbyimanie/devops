variable "number_of_instances" {
  description = "number of instances to be created"
  type        = number
  default     = 0
}

variable "project_id" {
  description = "project_id to be used"
  type        = string
  default     = ""
}

variable "instance_name" {
  description = "instance_name"
  type        = string
  default     = ""
}

variable "machine_type" {
  description = "machine_type"
  type        = string
  default     = ""
}

variable "zone" {
  description = "zone"
  type        = string
  default     = ""
}

variable "network_tags" {
  type        = list
  default     = [""]
  description = "network_tags to be used"

}

variable "subnetwork_project" {
  type        = string
  default     = ""
  description = "project_id of the subnetwork where the vpc resides"
}

variable "subnetwork_name" {
  type        = string
  default     = ""
  description = "subnetwork to be used"
}

variable "path_ssh_pubkey" {
  type        = string
  default     = ""
  description = "full path to ssh public key file"

}

variable "ssh_user" {
  type        = string
  default     = ""
  description = "ssh user to be used to login to the instance"
}

variable "network_tier" {
  type        = string
  default     = ""
  description = "network tier to be used"
}

variable "startup_script" {
  type        = string
  default     = ""
  description = "startup script to be used"
}

variable "labels" {
  description = "label names to be used"
  type        = map(string)
  default     = { "" = "" }
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
