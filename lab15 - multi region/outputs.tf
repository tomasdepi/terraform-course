
output "main_region_ami_name" {
    value = data.aws_ami.latest_ubuntu_20.id
}

output "europa_region_ami_name" {
    value = data.aws_ami.europa_ubuntu_20.id
}
