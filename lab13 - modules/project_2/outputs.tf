
output "server_standalone_ip" {
    value = module.server_standalone.web_server_public_ip
}

output "servers_ips" {
    value = module.servers[*].web_server_public_ip
}

output "servers_with_foreach_loop_ips" {
    value = values(module.servers_with_foreach_loop)[*].web_server_public_ip
}
