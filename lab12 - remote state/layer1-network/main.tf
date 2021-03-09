
provider "aws" {
    region = "us-east-2"
}

terraform {
    backend "s3" {
        bucket = "psh-terraform-remote-state"
        key    = "dev/network/terraform.tfstate"
        region = "us-east-2"
    }
}

data "aws_availability_zones" "current_az" {

}

resource "aws_vpc" "dev_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = format("%s-vpc", var.env)
        Onwer = "Depi"
    }
}

resource "aws_internet_gateway" "dev_igw" {
    vpc_id = aws_vpc.dev_vpc.id
    tags = {
        Name = format("%s-igw", var.env)
        Onwer = "Depi"
    }
}

resource "aws_subnet" "public_subnets" {
    count                   = length(var.public_subnet_cidrs)
    vpc_id                  = aws_vpc.dev_vpc.id
    cidr_block              = element(var.public_subnet_cidrs, count.index)
    availability_zone       = data.aws_availability_zones.current_az.names[count.index]
    map_public_ip_on_launch = true 
    tags = {
        Name = format("%s-vpc", var.env)
        Onwer = "Depi"
    }
}

resource "aws_route_table" "public_subnets" {
    vpc_id = aws_vpc.dev_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.dev_igw.id
    }
    tags = {
        Name = format("%s-vpc", var.env)
        Onwer = "Depi"
    }
}

resource "aws_route_table_association" "public_routes" {
    count          = length(aws_subnet.public_subnets[*].id)
    route_table_id = aws_route_table.public_subnets.id
    subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}
