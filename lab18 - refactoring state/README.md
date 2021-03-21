### Refactoring State

Commands - red are dangerous one, may broke infra state:

1. <span style="color:green">terraform state show</span> $resourse_name
2. <span style="color:green">terraform state list</span>
3. <span style="color:green">terraform state pull</span>
4. <span style="color:red">terraform state rm</span>
5. <span style="color:red">terraform state mv</span>

   May recive the param -state-out="terraform.tfstate" to specify where move the resource

6. <span style="color:red">terraform state push</span> terraform.tfstate

    This will override the state, its pushing a new one. Be sure to backup using state pull first


## Steps to migrate resources

1. Remove the resources from the .tf file
2. Remove and save the resource from the remote state:
   
    terraform state mv -state-out="terraform.tfstate" aws_eip.prod-ip1 aws_eip.prod-ip1
    
    Each time we run this command ti migrate a resource, will append (not overwrite) to the state-out file and also will create a backup of the last version

3. Move the generated terraform.tfstate file to the destination folder
4. Run terraform init, this will ask if you want to upload the local .tfstate to the remote bucket

