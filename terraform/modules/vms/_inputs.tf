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
    "master-nfs" = "172.16.1.10", 
    "worker01"   = "172.16.1.11", 
    #"worker02" = "172.16.1.12", 
    #"nfs"      = "172.16.1.15"
  }

  master_ports = [
    "6443","2379-2380", "10250-10252", "10255"
  ]

  worker_ports = [
    "10250","30000-32767" 
  ]
}

