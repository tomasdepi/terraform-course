
terraform {
  backend "s3" {
    bucket = "psh-terraform-remote-state"
    key    = "infra-stage/terraform.tfstate"
    region = "us-east-2"
  }
}
