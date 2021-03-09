
provider "aws" {
    region = "us-east-2"
}

module "vpc_prod" {
    source               = "../modules/aws_network"
    env                  = "prod"
    vpc_cidr             = "10.200.0.0/16"
    public_subnet_cidrs  = ["10.200.1.0/24", "10.200.2.0/24", "10.200.3.0/24"]
    private_subnet_cidrs = ["10.200.11.0/24", "10.200.21.0/24", "10.200.31.0/24"]
}

module "server_standalone" {
    source     = "../modules/aws_testserver"
    name       = "standalone"
    message    = "Depi says Hello"
    subnet_id  = module.vpc_prod.public_subnet_ids[0]
}

module "servers_count_loop" {
    source    = "../modules/aws_testserver"
    count     = length(module.vpc_prod.public_subnet_ids)
    name      = "multiple-${count.index}"
    message   = "Hello from subnet ${module.vpc_prod.public_subnet_ids[count.index]}"
    subnet_id = module.vpc_prod.public_subnet_ids[count.index]
}

module "servers_with_foreach_loop" {
    source    = "../modules/aws_testserver"
    for_each  = toset(module.vpc_prod.public_subnet_ids)
    message   = "Hello from subnet ${each.value}"
    subnet_id = each.value
    depends_on = [module.servers_count_loop]
}
