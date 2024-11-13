variable "rg_name" {
  type = string
  default = "default-rg-name"
}

variable "rg_location" {
  type = string
  default = "westeurope"
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

variable "administrator_login" {
  type = string
  default = "4dm1n157r470r"
}