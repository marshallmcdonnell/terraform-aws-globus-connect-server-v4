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

data "template_file" "user_data" {
  template  = "user-data.sh"
  vars      = {
    username               = var.username
    docker_version         = var.docker_version
    docker_compose_version = var.docker_compose_version
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
        from_port   = 443
        to_port     = 443
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
    user_data       = data.template_file.user_data.rendered
}
