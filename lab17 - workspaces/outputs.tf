
output "my_instance_ip" {
    value = aws_instance.my_instance.public_ip
}