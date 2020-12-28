variable "availability_zones" {
  type    = list(string)
  default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
}

variable "env_name" {
  type = string
}

variable "ngw_count" {
  type = number
}

variable "system_name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}
