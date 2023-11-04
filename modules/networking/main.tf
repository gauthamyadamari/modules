resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  

  tags = {
    Name = "tf-vpc-1"
    env = var.env
  }
}
#create public subnet
resource "aws_subnet" "public" {
  count      = var.subnet_count
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pub_sub_cidrs[count.index]

  tags = {
    Name = "tf-pub-1 -${count.index + 1}"
    env = var.env
  }
}
##created igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-1"
    env = var.env
  }
}
##create route table for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "rt-pub-table"
    env = var.env
  }
}
##subnet routetable association
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = aws_route_table.public.id
  count = var.subnet_count
}

##create private subnet

resource "aws_subnet" "private" {
  count      = var.subnet_count
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pri_sub_cidrs[count.index]

  tags = {
    Name = "tf-pri-1 -${count.index + 1}"
    env = var.env
  }
}
##create route table for private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "rt-pri-table"
    env = var.env
  }
}
##subnet routetable association
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.private.id
  count = var.subnet_count
}

