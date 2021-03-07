
output "instance_ip" {
    value = [
        aws_instance.lab6_instance.private_ip,
        aws_instance.lab6_instance.public_ip
    ]
}

output "sg2_id" {
    value = aws_security_group.lab6_sg.id
}