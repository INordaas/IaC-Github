variable "rg_name" {
  type = string
  default = "default-rg-name"
}

variable "rg_location" {
  type = string
  default = "westeurope"
}

variable "sa_base_name" {
  type = string
  default = "defaultsaname"
}

variable "account_tier" {
  type = string
  default = "Standard"
}

variable "replication_type" {
  type = string
  default = "GRS"
}

variable "sc_name" {
  type = string
  default = "default-sc-name"
}

variable sc_access_type {
  type = string
  default = "private"
}

variable "blob_name" {
  type = string
  default = "default-blob"
}

variable "blob_type" {
  type = string
  default = "Block"
}