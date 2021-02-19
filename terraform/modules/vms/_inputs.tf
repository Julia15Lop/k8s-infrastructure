# VM size

variable "vm_size" {
  type        = string
  description = "Virtual machine size"
  default     = "Standard_D2_v2" # 2 CPU, 7 GB
}

# VM Location

variable "location" {
  type        = string
  description = "Virtual machine location"
  default     = "West Europe"
}

variable "node_count" {
  type    = number
  default = 4
}

# Nodes

locals {
  nodes = {
    "master-nfs" = "10.0.1.10", 
    "worker01"   = "10.0.1.20", 
    #"worker02" = "10.0.1.30", 
    #"nfs"      = "10.0.1.40"
  }
}