
provider "aws" {
  region = "us-east-2"
}

resource "aws_key_pair" "depi_key" {
  key_name   = "depi-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAkaWlux13kFtAyxom7p1Db4jYCSf3kgO1UcR2LHb2rPIQYjzH47fUqw1ylIj1Mwa672UIO5sm1"
}

resource "aws_instance" "myserver" {
  ami                    = "ami-09246ddb00c7c4fef"
  instance_type          = "t3.nano"
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name               = aws_key_pair.depi_key.key_name

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/ec2-user/terraform",
      "cd /home/ec2-user/terraform",
      "touch hello.txt",
      "echo 'Terraform was here...' > terraform.txt"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip //Same as: aws_instance.myserver.public_ip
      private_key = file("/path/to/private_key")
    }
  }
}


resource "aws_security_group" "web" {
  name = "My-SecurityGroup"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
