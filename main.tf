provider "aws" {
  region = "us-east-1"
}
# terraform {
#   backend "s3" {
#     bucket = "terraform-bucket-backend-12"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#     dynamodb_table = "terraform_db"
#   }
# }

module "vpc" {
  source = "./modules/networking"
  vpc_cidr = var.vpc_cidr
  pub_sub_cidrs = var.pub_sub_cidrs
  pri_sub_cidrs = var.pri_sub_cidrs
  env = var.env
  #subnet_id = module.vpc.pub_sub_ids[0]

}

module "web" {
    source = "./modules/ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    env = var.env
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.pub_sub_ids[0]
  
}