# Region
variable "location" {
  type        = string
  description = "Azure region where Infrastructure will be created"
  default     = "West Europe"
}

# VM size
variable "vm_size" {
  type        = string
  description = "Virtual machine size"
  default     = "Standard_D1_v2" # 3.5 GB, 1 CPU 
}