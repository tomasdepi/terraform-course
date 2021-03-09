
provider "aws" {
    region = "us-east-2"
}

module "my_vcp_default" {
    source = "../modules/aws_network"
}

module "my_vcp_staging" {
    source               = "../modules/aws_network"
    env                  = "staging"
    vpc_cidr             = "10.100.0.0/16"
    public_subnet_cidrs  = ["10.100.1.0/24", "10.100.2.0/24"]
    private_subnet_cidrs = []
}

module "my_vcp_prod" {
    source               = "../modules/aws_network"
    env                  = "prod"
    vpc_cidr             = "10.200.0.0/16"
    public_subnet_cidrs  = ["10.200.1.0/24", "10.200.2.0/24"]
    private_subnet_cidrs = ["10.200.11.0/24", "10.200.21.0/24"]
}


// terraform {
//     backend "s3" {
//         bucket = "psh-terraform-remote-state"
//         key    = "dev/modules/terraform.tfstate"
//         region = "us-east-2"
//     }
// }
