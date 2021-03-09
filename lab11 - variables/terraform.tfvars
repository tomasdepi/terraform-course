aws_region = "us-east-2"

port_list = ["80", "443", "8080"]

instance_size = "t2.micro"

tags = {
        Owner   = "Depi"
        Env     = "Dev"
        Project = "Terraform course"
    }

key_pair = "CanadaKey"
