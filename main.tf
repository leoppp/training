#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-4809fd31
#
# Your subnet ID is:
#
#     subnet-1db13054
#
# Your security group ID is:
#
#     sg-b2a021ca
#
# Your Identity is:
#
#     Idol-training-koala
#
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"

  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  # ...
  ami                    = "ami-4809fd31"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-1db13054"
  vpc_security_group_ids = ["sg-b2a021ca"]

  tags {
    "Identity" = "Idol-training-koala"
    "Name"     = "Leo's Thing"
    "Company"  = "theidol.com"
    "Index" = "${count.index}"
  }
  count = "3"
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}

terraform {
  backend "atlas" {
    name    = "leoponton/training"
  }
}
