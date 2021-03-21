
terraform {
  backend "s3" {
    bucket = "psh-terraform-remote-state"
    key    = "infra-all/terraform.tfstate"
    region = "us-east-2"
  }
}
