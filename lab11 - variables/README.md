Ways to provide variable values:

1. by cli
terraform apply -var="password=0123456789" -var="instance_size=t3.small"

2. by env var
export TF_VAR_instance_size=t3.medium
terraform apply

3. provide a file with variables
   by default if terraform.tfvars is present, terraform will read and use its values
   but we can specify in cli which file to use
   terraform apply -var-file="vars_prod.tfvars"

Precedence:
Environment Values
terraform.tfvars
terraform.tfvars.json
*.auto.tfvars or *.auto.tfvars.json
any -var o -var-file in cli
