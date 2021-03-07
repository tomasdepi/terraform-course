

provider "aws"{
    region = "us-east-2"
}

resource "aws_security_group" "lab3"{
    name = "Lab 3 - Dynamic Blocks"

    dynamic "ingress" {
        for_each = ["80", "443", "4589", "8080"]
        content {
            #description = "Allow port for HTTP"
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
