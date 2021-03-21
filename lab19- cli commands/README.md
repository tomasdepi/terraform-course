
### Useful CLI Commands

1. While updating one resource, terraform will check the state of all resources, we can limit this search to only the resources we want and theirs dependencies:

    `terraform apply -target aws_instance.web`

2. We can skip the manual approval, useful for CI/CD and automation

    `terraform apply -auto-approve`

3. We can validate the sintax:

    `terraform validate`

4. See the outputs:

    `terraform output`

5. Print the configuration and default values:

    `terraform show`

6. Get an Interactive Console to test the functions for example

    `terraform console`

7. If someone changes resources manually in AWS or other cloud provider, we can update our state:

    `terraform refresh`

    This will just update the state file, later we can run terraform plan and see what changed and the diferences

8. Use Log Levels to get a more verbose output while running terraform:

    We need to set the env variable TF_LOG, `export TF_LOG=TRACE`

    Posible Values: TRACE, DEBUG, INFO, WARN or ERROR.
