resource "aws_vpc" "vpc_phonevalidator" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true 
  enable_dns_hostnames = true 

  tags = {
    Name = "vpc_phonevalidator"
  }
}

resource "aws_subnet" "vpc_phonevalidator_public_subnet" {
  # Number of public subnet 
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index + 2}.0/24"
  vpc_id                  = aws_vpc.vpc_phonevalidator.id
  map_public_ip_on_launch = true 

  tags = {
    Name = "vpc_phonevalidator-public-subnet-${count.index}"
  }
}

resource "aws_db_subnet_group" "subnet_group_phonevalidator" {
  name       = "subnet_group_phonevalidator"
  subnet_ids = [aws_subnet.vpc_phonevalidator_public_subnet[0].id, aws_subnet.vpc_phonevalidator_public_subnet[1].id]

  tags = {
    Name = "subnet_group_phonevalidator"
  }
}