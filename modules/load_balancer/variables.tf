variable "name_prefix" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "health_probe_path" {
  type    = string
  default = "/"
}

variable "health_probe_interval" {
  type    = number
  default = 5
}

variable "health_probe_unhealthy_threshold" {
  type    = number
  default = 2
}

variable "tags" {
  type = map(string)
}