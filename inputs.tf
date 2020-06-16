variable "region" {
    default = "us-east-2"
}

variable "amis" {
    type = map(string)
    default = {
        "us-east-1" = "ami-b374d5a5"
        "us-east-2" = "ami-0d5d9d301c853a04a"
    }
}

variable "username" {
  default = "root"
}

# Docker compose version to provision the server with
variable "docker_version" {
  default = "19.03.7"
}

# Docker compose version to provision the server with
variable "docker_compose_version" {
  default = "1.25.4"
}

variable "ssh_key_file" {
  default = "~/.ssh/id_rsa"
}

variable "ssh_key_name" {
  default = "globus_connect_server"
}

variable "ssh_username" {
  default = "ubuntu"
}

variable "security_group_name" {
  default = "allow_traffic"
}
