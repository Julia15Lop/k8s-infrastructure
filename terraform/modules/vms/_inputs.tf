# Resource Group Name
variable "resource_group_name" {
  type = string
}

variable "k8s_nic_id" {
  type = string
}

variable "vm_size" {
  type        = string
  description = "Virtual machine size"
  default     = "Standard_D1_v2"
}

variable "location" {
  type        = string
  description = "Virtual machine size"
  default     = "West Europe"
}

variable "stg_account" {
  type = string
}