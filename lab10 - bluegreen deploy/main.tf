
provider "aws" {
    region = "us-east-2"
}

data "aws_availability_zones" "current_AZ" {}

data "aws_ami" "latest_ubuntu_20" {
    most_recent = true
    owners = ["099720109477"]
    
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-*"]
    }
}

resource "aws_security_group" "web_sg" {
    dynamic "ingress"{
        for_each = ["80","443"]
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

resource "aws_launch_configuration" "web_launch_configuration" {
    name_prefix     = "web_config-"
    image_id        = data.aws_ami.latest_ubuntu_20.id
    instance_type   = "t2.micro"
    security_groups = [aws_security_group.web_sg.id]
    user_data       = file("user_data.sh")

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "web_autoscaling_group" {
    name                      = "ASG-${aws_launch_configuration.web_launch_configuration.name}"

    max_size                  = 3
    min_size                  = 1
    desired_capacity          = 1
    min_elb_capacity          = 1
    health_check_type         = "ELB"

    launch_configuration      = aws_launch_configuration.web_launch_configuration.name
    vpc_zone_identifier       = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
    load_balancers            = [aws_elb.web_elb.name]

    dynamic "tag" {
        for_each = {
            Name  = "My WebServer"
            Owner = "Depi"
        }
        content {
            key                 = tag.key
            value               = tag.value
            propagate_at_launch = true
        }
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_elb" "web_elb" {
    name               =  "Web-ELB"
    availability_zones = [data.aws_availability_zones.current_AZ.names[0], data.aws_availability_zones.current_AZ.names[0]]
    security_groups    = [aws_security_group.web_sg.id]

    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }

}

resource "aws_default_subnet" "default_az1" {
    availability_zone = data.aws_availability_zones.current_AZ.names[0]
}

resource "aws_default_subnet" "default_az2" {
    availability_zone = data.aws_availability_zones.current_AZ.names[1]
}
