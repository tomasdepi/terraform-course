## Import resources into Terraform

1. Run 'terraform init'
2. Create the empty block related to the resource we want to import
3. Run 'terraform import resource_type.resource_name resource_id'
    Example: terraform import aws_instance.server_1 i-02a3fa6fe2e2c32a9
4. Fill the block with required arguments
5. Run 'terraform plan' and check if terraform will replace the resource due a missconfigurated default values