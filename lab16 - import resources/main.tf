
provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "server_1" {
    instance_type = "t2.micro"
    ami           = "ami-07a0844029df33d7d"
}