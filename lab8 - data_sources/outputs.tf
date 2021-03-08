output "region" {
    value = data.aws_region.current_region
}

output "account_id" {
    value = data.aws_caller_identity.current_identity
}

output "availability_zone" {
    value = data.aws_availability_zones.current_availability_zones.names
}

output "all_vpcs_ids" {
    value = data.aws_vpcs.all_vpcs.ids
}