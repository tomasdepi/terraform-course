
provider "aws" {
    region = "us-east-2"
}

data "aws_availability_zones" "available" {}

data "aws_ami" "latest_amazon_linux" {
    owners      = ["amazon"]
    most_recent = true
    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

resource "aws_eip" "prod-ip1" {}
resource "aws_eip" "prod-ip2" {}

resource "aws_eip" "stag-ip1" {}
resource "aws_eip" "stag-ip2" {}
resource "aws_eip" "stag-ip3" {}
