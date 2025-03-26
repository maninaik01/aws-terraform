
provider "aws" {
  region  = "us-east-2"
  profile = "mani-aws"
}


terraform {
  backend "s3" {
    bucket  = "terraform-state-file-training"
    key     = "ec2/102/vpc-state"
    region  = "us-east-2"
    profile = "mani-aws"
  }
}




