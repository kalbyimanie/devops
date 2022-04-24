variable "project_id_of_the_vpc" {
  description = "project_id_of_the_vpc"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "vpc_id"
  type        = string
  default     = ""
}


variable "number_of_subnetwork" {
  description = "number of subnetwork to be created"
  type        = number
  default     = 1
}

variable "project_id" {
  description = "project_id"
  type        = string
  default     = ""
}

variable "subnetwork_name" {
  description = "subnetwork name"
  type        = string
  default     = ""
}

variable "region_name" {
  description = "region name"
  type        = string
  default     = ""
}

variable "primary_ip_cidr_range" {
  description = "ip_cidr_range to be used"
  type        = string
  default     = ""
}

variable "secondary_ip_cidr_range" {
  description = "ip_cidr_range to be used"
  type        = string
  default     = ""
}
