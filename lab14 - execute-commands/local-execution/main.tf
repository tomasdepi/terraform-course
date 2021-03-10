
provider "aws" {
    region = "us-east-2"
}

resource "null_resource" "command_1" {
    provisioner "local-exec" {
        command = "echo Hello World"
    }
}

resource "null_resource" "command_2" {
    provisioner "local-exec" {
        command = "ping -c 5 google.com"
    }
    depends_on = [null_resource.command_1]
}

resource "null_resource" "command_3" {
    provisioner "local-exec" {
        interpreter = ["python3", "-c"]
        command = "print('Hello World From Python')"
    }
    depends_on = [null_resource.command_2]
}

resource "null_resource" "command_4" {
    provisioner "local-exec" {
        environment = {
            NAME = "Depi"
            ROL  = "DevOps Engineer"
        }
        command = "echo $NAME is a $ROL"
    }
    depends_on = [null_resource.command_3]
}

resource "aws_instance" "myserver" {
    ami           = "ami-09246ddb00c7c4fef"
    instance_type = "t3.nano"

    provisioner "local-exec" {
    command = "echo ${aws_instance.myserver.private_ip} >> log.txt"
    }
    depends_on = [null_resource.command_4]
}

resource "null_resource" "command_5" {
    provisioner "local-exec" {
        command = "echo Terraform script finish: $(date)"
    }
    depends_on = [aws_instance.myserver]
}
