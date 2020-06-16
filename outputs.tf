output "username" {
    value = var.ssh_username
}

output "ip" {
    value = aws_instance.globus_server.public_ip
}

output "public_dns" {
    value = aws_instance.globus_server.public_dns
}

