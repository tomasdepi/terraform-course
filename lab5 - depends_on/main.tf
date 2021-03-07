
provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "lab5_instace_1" {
    ami                    = "ami-09246ddb00c7c4fef"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.lab5_sg.id]
    tags                   = {
        Name = "Lab5 - Instance 1"
    }
}

resource "aws_instance" "lab5_instace_2" {
    ami                    = "ami-09246ddb00c7c4fef"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.lab5_sg.id]
    tags                   =  {
        Name = "Lab5 - Instance 2"
    }

    depends_on = [aws_instance.lab5_instace_1]
}

resource "aws_instance" "lab5_instace_3" {
    ami                    = "ami-09246ddb00c7c4fef"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.lab5_sg.id]
    tags                   = {
        Name = "Lab5 - Instance 3"
    }

    depends_on = [aws_instance.lab5_instace_2]
}

resource "aws_security_group" "lab5_sg" {
    dynamic "ingress" {
        for_each = ["80", "443", "8080"]
        content {
            from_port   = ingress.value
            to_port     = ingress.value
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}