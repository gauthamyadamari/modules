resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  count = var.ec2_count 
  subnet_id = var.subnet_id
  

  tags = {
    Name = "HelloWorld"
    env = var.env
  }
}