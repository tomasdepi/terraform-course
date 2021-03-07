provider "aws" {
  region = "us-east-2"
}

resource "aws_key_pair" "depi_key" {
  key_name   = "depi-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC27k2XUpckWvP2+WpYwITP1dr2cJjAXBmxhvrbaVoCAIesNgTBbpztzgR3Q7gkZPz/tD+yy/NUvzV2ki6AL5ePOx4b556b/jtoprElL8vloG04vYt2oG6A+RMrWp9MT4y5pWOKcRueHDf0BrDsHeXHSGAdpg7Z7NUkbwXxpkyP941n3U/2IIpvv0PW2gc6JGRmgdjKvNt+/FXlIYIROQYNjjLLG88k4tWsDjI9nQqCjkZk4Qv/IRfyrLwSA5OLlHtMi4EaPZJFkBtkaWlux13kFtAyxom7p1Db4jYCSf3kgO1UcR2LHb2rPIQYjzH47fUqw1ylIj1Mwa672UIO5sm1"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-09246ddb00c7c4fef"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.depi_key.key_name
  
  tags = {
      Name = "Depi's Instance"
  }
}
