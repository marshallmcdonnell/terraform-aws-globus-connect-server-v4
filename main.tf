provider "aws" {
    region  = var.region
}

terraform {
    backend "s3" {
        bucket  = "tf-remote-state-32375"
        region  = "us-east-2"
        key     = "global/instance/terraform.tfstate"
    }
}

resource "aws_key_pair" "key" {
    key_name    = var.ssh_key_name
    public_key  = file("${var.ssh_key_file}.pub")
}

resource "aws_security_group" "allow_traffic" {
    name = var.security_group_name

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 2811
        to_port     = 2811
        protocol    = "tcp"
        cidr_blocks = ["54.237.254.192/29"]
    }

    ingress {
        from_port   = 7512
        to_port     = 7512
        protocol    = "tcp"
        cidr_blocks = ["54.237.254.192/29"]
    }

    ingress {
        from_port   = 50000
        to_port     = 51000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "globus_server" {
    ami             = var.amis[var.region]
    instance_type   = "t2.micro"
    key_name        = var.ssh_key_name
    vpc_security_group_ids = [aws_security_group.allow_traffic.id]

    connection {
        type    = "ssh"
        user    = var.ssh_username
        host    = self.public_dns
        private_key  = file("${var.ssh_key_file}")
    }

    provisioner "file" {
        source      = "globus-server"
        destination = "globus-server"
    }

    provisioner "remote-exec" {
        inline = [
            "sudo yum install -y docker",
            "sudo touch /etc/containers/nodocker",
            "docker build -t globus-server globus-server",
            "docker run -p 2811:2811 -p 50000-51000:50000-51000 -p 7512:7512 -e GLOBUS_USER=${var.globus_user} -e GLOBUS_PASSWORD=${var.globus_password} globus-server",
        ]
    }
}
