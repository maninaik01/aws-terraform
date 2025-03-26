resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/23"

  tags = {
    Name = "main"
  }
}

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

resource "aws_subnet" "pri_subnets" {
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
  for_each = aws_subnet.pub_subnets
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

resource "aws_route_table_association" "public" {
 for_each = aws_subnet.pub_subnets
 subnet_id = aws_subnet.pub_subnets[each.key].id
 route_table_id = aws_route_table.public-rt[each.key].id
  
}



resource "aws_eip" "nat_gw" {
  for_each = local.private_subnets


  tags = {
    Name = "eip-${each.value.name}"
    Environment = "Production"
    Project = "AI"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  for_each = local.private_subnets
  
  allocation_id = aws_eip.nat_gw[each.key].id
  subnet_id = aws_subnet.pri_subnets[each.key].id

  tags = {
    Name = "NAT-gw-${each.value.name}"
    Environment = "Production"
    Project = "AI"
  }
}


resource "aws_route_table" "private-rt" {
  for_each = aws_subnet.pri_subnets
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw[each.key].id
  }

  tags = {
    Name = "private-route"
    Environment = "Production"
    Project = "AI"
  }
}

resource "aws_route_table_association" "private" {
 for_each = aws_subnet.pri_subnets
 subnet_id = aws_subnet.pri_subnets[each.key].id
 route_table_id = aws_route_table.private-rt[each.key].id
  
}