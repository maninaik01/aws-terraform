resource "aws_instance" "bastion" {
  ami           = "ami-0d0f28110d16ee7d6"
  instance_type = "t3.micro"
  availability_zone = "us-east-2a"
  subnet_id = aws_subnet.pub_subnets["a"].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  tags = {
    Name = "bastion-az1a-instance"
    Environment = "Production"
    Project = "AI"
  }
}


resource "aws_security_group" "allow_tls" {
  name        = "Bastion secuity group"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}