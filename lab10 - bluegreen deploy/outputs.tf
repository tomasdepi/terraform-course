
output "web_elb_ip" {
    value = aws_elb.web_elb.dns_name
}