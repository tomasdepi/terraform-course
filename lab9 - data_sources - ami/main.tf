
provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "lab9_instance"{
    ami  = data.aws_ami.latest_ubuntu_20.id
}

data "aws_ami" "latest_ubuntu_20" {
    most_recent = true
    owners = ["099720109477"]
    
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-*"]
    }
}

output "latest_ubuntu" {
    value = data.aws_ami.latest_ubuntu_20
}