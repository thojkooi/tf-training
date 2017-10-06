#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-5a922335
#
# Your subnet ID is:
#
#     subnet-faec2e91
#
# Your security group ID is:
#
#     sg-c7eb27ad
#
# Your Identity is:
#
#     asas-bulldog
#

terraform {
  backend "atlas" {
    name = "thojkooi/training"
  }
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-central-1"
}

variable "total_aws_instances" {
  default = 2
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  instance_type          = "t2.micro"
  ami                    = "ami-5a922335"
  subnet_id              = "subnet-faec2e91"
  vpc_security_group_ids = ["sg-c7eb27ad"]
  count                  = "${var.total_aws_instances}"

  tags {
    Identity = "asas-bulldog"
    One      = "One"
    Two      = "Two"
    Name     = "web ${count.index +1 }/${var.total_aws_instances}"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
