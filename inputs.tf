variable "region" {
    default = "us-east-2"
}

variable "amis" {
    type = map(string)
    default = {
        "us-east-2" = "ami-0a54aef4ef3b5f881"
    }
}

variable "ssh_key_file" {
  default = "~/.ssh/id_rsa"
}

variable "ssh_key_name" {
  default = "globus_connect_server"
}

variable "ssh_username" {
  default = "ec2-user"
}

variable "security_group_name" {
  default = "allow_traffic"
}

variable "globus_user" {}
variable "globus_password" {}
variable "activation_user" {}
variable "activation_password" {}
