variable "aws_region" {
    description = "my amazon region"
    type        = string // it can be also number or bool
    default     = "us-east-2" 
}

variable "port_list" {
    description = "list of port to open in SG"
    type        = list(any)
    default     = ["80", "443"]
}

variable "instance_size" {
    description = "EC2 isntance size"
    type        = string
    default     = "t3.micro"
}

variable "tags" {
    description = "Tags to apply to resources"
    type        = map(any)
    default     = {
        Owner   = "Depi"
        Env     = "Test"
        Project = "Terraform course"
    }
}

variable "key_pair" {
  description = "SSH Key pair name to ingest into EC2"
  type        = string
  default     = "CanadaKey"
  sensitive   = true
}

variable "password" {
  description = "Please Enter Password lenght of 10 characters!"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.password) == 10
    error_message = "Your Password must be 10 characted exactly!!!"
  }
}
