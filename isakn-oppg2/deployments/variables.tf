variable "rg_name" {
  type    = string
  default = "default-rg-name"
}

variable "rg_location" {
  type    = string
  default = "westeurope"
}

variable "sa_base_name" {
  type    = string
  default = "defaultsaname"
}

variable "account_tier" {
  type    = string
  default = "Standard"
}

variable "replication_type" {
  type    = string
  default = "GRS"
}

variable "sc_name" {
  type    = string
  default = "default-sc-name"
}

variable "sc_access_type" {
  type    = string
  default = "private"
}

variable "blob_name" {
  type    = string
  default = "default-blob"
}

variable "blob_type" {
  type    = string
  default = "Block"
}

variable "nsg_name" {
  type    = string
  default = "default-nsg-name"
}

variable "vnet_name" {
  type    = string
  default = "default-vnet-name"
}

variable "address_space" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_name" {
  type    = string
  default = "default-subnet-name"
}

variable "subnet_prefix" {
  type    = string
  default = "10.0.2.0/24"
}

variable "sqlserver_name" {
  type = string
  default = "default-sqlserver-name"
}   

variable "sqlserver_version" {
  type = string
  default = "12.0"
}

variable "administrator_login_password" {
  type = string
  description = "This should be set with tfvars file, do NOT use the default"
}

variable "db_name" {
  type = string
  default = "default-db-name"
}
