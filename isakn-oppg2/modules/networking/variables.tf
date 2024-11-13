variable "nsg_name" {   
  type = string
  default = "default-nsg-name"
}

variable "rg_location" {
  type = string
  default = "westeurope"
}

variable "rg_name" {
  type = string
  default = "default-rg-name"
}

variable "vnet_name" {
  type = string
  default = "default-vnet-name"
}

variable "address_space" {
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_name" {
  type = string
  default = "default-subnet-name"
}

variable "subnet_prefix" {
  type = string
  default = "10.0.2.0/24"
}

variable "public_ip_name" {
  type = string
  default = "default-ip-name"
}

variable "lb_name" {
  type = string
  default = "default-lb-name"
}

variable "frontend_ip_name" {
  type = string
  default = "default-frontend-ip-name"
}