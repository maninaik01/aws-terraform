resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/23"

  tags = {
    Name = "main"
  }
}


# resource "aws_subnet" "az1a" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.0.0/25"
#   availability_zone = "us-east-2a"

#   tags = {
#     Name = "private-subnet-2a"
#   }
# }


# resource "aws_subnet" "az1b" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.0.128/25"
# availability_zone = "us-east-2b"

#   tags = {
#     Name = "private-subnet-2b"
#   }
# }

# resource "aws_subnet" "az1c" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.1.0/25"
# availability_zone = "us-east-2c"

#   tags = {
#     Name = "private-subnet-2c"
#   }
# }

locals {
  private_subnets = {
    "a" = {cidr_block = "10.0.0.0/25", az = "us-east-2a", name="private-subnet-2a" }
    "b" = {cidr_block = "10.0.0.128/25", az = "us-east-2b",name="private-subnet-2b" }
    "c" = {cidr_block = "10.0.1.0/25", az = "us-east-2c",name="private-subnet-2c" }
  }
  public_subnets = {
    "a" = {cidr_block = "10.0.1.128/27", az = "us-east-2a", name="public-subnet-2a" }
    "b" = {cidr_block = "10.0.1.160/27", az = "us-east-2b",name="public-subnet-2b" }
    "c" = {cidr_block = "10.0.1.192/27", az = "us-east-2c",name="public-subnet-2c" }
  }
}

resource "aws_subnet" "subnets" {
  for_each = local.private_subnets

  vpc_id = aws_vpc.main.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = each.value.name
    Environment = "Production"
    Project = "AI"
  }
}


resource "aws_subnet" "pub_subnets" {
  for_each = local.public_subnets

  vpc_id = aws_vpc.main.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = each.value.name
    Environment = "Production"
    Project = "AI"
  }
}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id # internet gateway depends on VPC

  tags = {
    Name = "internet-gw"
    Environment = "Production"
    Project = "AI"
  }
}


resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route"
    Environment = "Production"
    Project = "AI"
  }
}


# resource "aws_eip" "auto-eip" {

# }

# resource "aws_nat_gateway" "example" {
#   allocation_id = aws_eip.auto-eip.id
#   subnet_id     = aws_subnet.subnets.id

#   tags = {
#     Name = "natgw"
#     Environment = "Production"
#     Project = "AI"
#   }

#   # To ensure proper ordering, it is recommended to add an explicit dependency
#   # on the Internet Gateway for the VPC.
#   depends_on = [aws_internet_gateway.igw]
# }

resource "aws_eip" "nat_gw" {
  for_each = local.private_subnets

#   domain = "vpc"

  tags = {
    Name = "eip-${each.value.name}"
    Environment = "Production"
    Project = "AI"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  for_each = local.private_subnets
  
  allocation_id = aws_eip.nat_gw[each.key].id
  subnet_id = aws_subnet.subnets[each.key].id

  tags = {
    Name = "NAT-gw-${each.value.name}"
    Environment = "Production"
    Project = "AI"
  }
}

