variable "serviceplan_name" {
  type = string
  default = "default-serviceplan"
}

variable "rg_name" {
  type = string
  default = "default-rg-name"
}

variable "rg_location" {
  type = string
  default = "westeurope"
}


variable "os_type" {
    type = string
  default = "Linux"

}
  variable "sku_name" {
    type = string
    default = "P1v2"
  }

  variable "webapp_name" {
    type = string
    default = "default-webapp-name"
    
  }