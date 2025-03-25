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


terraform {
  backend "s3" {
    bucket = "terraform-state-file-training"
    key    = "ec2/101/state"
    region = "us-east-2"
    profile = "mani-aws"
  }
}

resource "aws_instance" "app" {
  count =  var.number_of_app_instance
  ami           = var.instance_ami 
  instance_type = var.app_instance_type

  tags = {
    Name = "maniAppserver"
    Owner = "mani"
    Team  =  "Something"
  }
}

resource "aws_instance" "db" {
  count =  var.number_of_db_instance
  ami           = var.instance_ami 
  instance_type = var.db_instance_type

  tags = {
    Name = "maniAppserver"
    Owner = "mani"
    Team  =  "Something"
  }
}



