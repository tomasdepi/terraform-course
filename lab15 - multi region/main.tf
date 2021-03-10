
provider "aws" {
    region = "us-east-2"
}

provider "aws" {
    region = "eu-central-1"
    alias   = "EUROPA"
}


data "aws_ami" "latest_ubuntu_20" {
    most_recent = true
    owners      = ["099720109477"]
    
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-*"]
    }
}

data "aws_ami" "europa_ubuntu_20" {
    provider    = aws.EUROPA
    most_recent = true
    owners      = ["099720109477"]
    
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-*"]
    }
}

resource "aws_instance" "main_region_instance" {
    ami                    = data.aws_ami.latest_ubuntu_20.id
    instance_type          = "t2.micro"
}

resource "aws_instance" "europa_region_instance" {
    provider               = aws.EUROPA
    ami                    = data.aws_ami.europa_ubuntu_20.id
    instance_type          = "t2.micro"
}

