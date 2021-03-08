
provider "aws" {
    region = "us-east-2"
}

data "aws_region" "current_region" {}

data "aws_caller_identity" "current_identity" {}

data "aws_availability_zones" "current_availability_zones" {}

data "aws_vpcs" "all_vpcs" {}

# the VPC "Depi" must be created first outside terraform
# the idea of data is fetch resources that whether or not have been created with terraform
data "aws_vpc" "my_vpc" {
    tags = {
        Name = "Depi"
    }
}

resource "aws_subnet" "main" {
    vpc_id            = data.aws_vpc.my_vpc.id
    availability_zone = data.aws_availability_zones.current_availability_zones.names[0]
    cidr_block        = "10.0.0.0/24"
}
