

provider "aws"{
    region = "us-east-2"
}

resource "aws_instance" "my_instance" {
  ami                    = "ami-09246ddb00c7c4fef"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web.id]
  # user_data              = file("user_data.sh")
  user_data              = templatefile("user_data.tpl", {
      name     = "Tomas"
      lastname = "Depi"
      hobbies  = ["Magic", "Anime", "Reading"]
  })
}

resource "aws_security_group" "web"{
    name = "Lab 2 Web SG"

    ingress {
        description = "Allow port for HTTP"
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port   = 443
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0 # all ports
        to_port   = 0
        protocol  = "-1" # all protocols
        cidr_blocks = ["0.0.0.0/0"]
    }
}
