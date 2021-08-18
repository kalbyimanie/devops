variable "network_tags" {
  type    = list
  default = []
}

variable "network_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "firewall_name" {
  type = string
}

variable "list_ports" {
  type    = list
  default = []
}

variable "source_ranges" {
  type    = list
  default = []
}

variable "protocol" {
  type = string
}
