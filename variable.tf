variable "app_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_ami" {
  type    = string
  default = "ami-0d0f28110d16ee7d6"
}

variable "number_of_app_instance" {
  type    = number
  default = 1
}

variable "db_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "number_of_db_instance" {
  type    = number
  default = 0
}
