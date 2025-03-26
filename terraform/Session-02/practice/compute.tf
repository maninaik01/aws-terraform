resource "aws_instance" "web" {
  ami           = "ami-0d0f28110d16ee7d6"
  instance_type = "t3.micro"
  availability_zone = "us-east-2a"
  subnet_id = aws_subnet.pri_subnets["a"].id

  tags = {
    Name = "az1-instance"
    Environment = "Production"
    Project = "AI"
  }
}

resource "aws_instance" "web1b" {
  ami           = "ami-0d0f28110d16ee7d6"
  instance_type = "t3.micro"
  availability_zone = "us-east-2b"
  subnet_id = aws_subnet.pri_subnets["b"].id

  tags = {
    Name = "az2-instance"
    Environment = "Production"
    Project = "AI"
  }
}

resource "aws_instance" "web1c" {
  ami           = "ami-0d0f28110d16ee7d6"
  instance_type = "t3.micro"
  availability_zone = "us-east-2c"
  subnet_id = aws_subnet.pri_subnets["c"].id

  tags = {
    Name = "az3-instance"
    Environment = "Production"
    Project = "AI"
  }
}