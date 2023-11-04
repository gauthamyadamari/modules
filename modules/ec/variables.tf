variable "ami_id" {
     type = string
  
}
variable "instance_type" {
  type = string
}
variable "env" {
  type = string
}
variable "ec2_count" {
  type = string
  default = 1
}
variable "subnet_id" {
  
}
variable "vpc_id" {
  
}