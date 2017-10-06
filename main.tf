#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-5a922335
#
# Your subnet ID is:
#
#     subnet-aec9cad4
#
# Your security group ID is:
#
#     sg-c7eb27ad
#
# Your Identity is:
#
#     asas-panther
#

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_default_region" {
  default = "eu-central-1"
}

variable "num_webs" {
  default = 3
}

terraform {
	backend "atlas" {
		name = "bennycornelissen-avisi/training"
	}
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_default_region}"
}

resource "aws_instance" "web" {
  count                  = "${var.num_webs}"
  ami                    = "ami-5a922335"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-aec9cad4"
  vpc_security_group_ids = ["sg-c7eb27ad-1"]

  tags {
    Identity = "asas-panther"
    Foo      = "Bar"
    Bar      = "Foo"
    Name     = "Web ${(count.index + 1)}/${(var.num_webs)}"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
