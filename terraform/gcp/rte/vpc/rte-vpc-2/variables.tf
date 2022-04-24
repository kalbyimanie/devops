variable "project_id" {
  description = "gcp project id"
  type        = string
  default     = ""
}

variable "vpc_network_name" {
  description = "name of the vpc network"
  type        = string
  default     = ""
}

variable "auto_create_subnetworks" {
  description = "whether to auto-create subnet or not—using custom mode subnet"
  type        = bool
  default     = false
}

variable "mtu" {
  description = "value of the network mtu in bytes—maximum value is 1500"
  type        = number
  default     = 1460
}

variable "routing_mode" {
  description = "routing mode—GLOBAL or REGIONAL"
  type        = string
  default     = "GLOBAL"
}

variable "delete_default_routes_on_create" {
  description = "whether to delete default route when creating vpc—if set to true, network range of (0.0.0.0/0) will be deleted immediately after network creation"
  type        = bool
  default     = false
}
