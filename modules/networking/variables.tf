variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "subnet_count" {
  default = 3
}
variable "pub_sub_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "pri_sub_cidrs" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}
variable "env" {
  type = string
}