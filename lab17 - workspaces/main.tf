
provider "aws" {
    region = "us-east-2"
}

terraform {
    backend "s3" {
        bucket = "psh-terraform-remote-state"
        key    = "prod/terraform.tfstate"
        region = "us-east-2"
    }
}

resource "aws_instance" "my_instance" {
    ami                    = "ami-09246ddb00c7c4fef"
    instance_type          = "t2.micro"
    
    tags = {
        Name = "Server ${terraform.workspace}"
    }
}
