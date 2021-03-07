

provider "aws"{
    region = "us-east-2"
}

resource "aws_key_pair" "depi_key" {
  key_name   = "depi-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC27k2XUpckWvP2+WpYwITP1dr2cJjAXBmxhvrbaVoCAIesNgTBbpztzgR3Q7gkZPz/tD+yy/NUvzV2ki6AL5ePOx4b556b/jtoprElL8vloG04vYt2oG6A+RMrWp9MT4y5pWOKcRueHDf0BrDsHeXHSGAdpg7Z7NUkbwXxpkyP941n3U/2IIpvv0PW2gc6JGRmgdjKvNt+/FXlIYIROQYNjjLLG88k4tWsDjI9nQqCjkZk4Qv/IRfyrLwSA5OLlHtMi4EaPZJFkBtkaWlux13kFtAyxom7p1Db4jYCSf3kgO1UcR2LHb2rPIQYjzH47fUqw1ylIj1Mwa672UIO5sm1"
}

resource "aws_eip" "lb" {
  instance = aws_instance.lab4_instance.id
  vpc      = true
}

resource "aws_instance" "lab4_instance" {
  ami                    = "ami-09246ddb00c7c4fef"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.depi_key.key_name
  vpc_security_group_ids = [aws_security_group.lab4_sg.id]
  # user_data              = file("user_data.sh")
  user_data              = templatefile("user_data.tpl", {
      name     = "Tomas"
      lastname = "Depi"
      hobbies  = ["Magic", "Anime", "Reading"]
  })

  lifecycle {
      create_before_destroy = true
  }
}

resource "aws_security_group" "lab4_sg"{
    name = "Lab 4 Web SG"

    dynamic "ingress" {
        for_each = ["80", "443"]
        content {
            description = "Allow port for HTTP"
            from_port = ingress.value
            to_port   = ingress.value
            protocol  = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
        from_port = 0 # all ports
        to_port   = 0
        protocol  = "-1" # all protocols
        cidr_blocks = ["0.0.0.0/0"]
    }
}
