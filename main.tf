terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= v1.11.2"
}


provider "aws" {
  region  = "us-east-2"
  profile = "mani-aws"
}

resource "aws_instance" "app" {
  count =  3
  ami           = "ami-0d0f28110d16ee7d6"
  instance_type = "t2.micro"

  tags = {
    Name = "maniAppserver"
    Owner = "mani"
    Team  =  "Something"
  }
}


