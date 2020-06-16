provider "aws" {
    region = var.aws_region
}

terraform {
    backend "s3" {
        bucket  = "tf-remote-state-32375"
        region  = "us-east-2"
        key     = "global/s3/terraform.tfstate"
        encrypt = true
    }
}

resource "random_id" "tf-state-id" {
    byte_length = 2
}

resource "aws_s3_bucket" "tf_remote_state" {
    bucket = "tf-remote-state-${random_id.tf-state-id.dec}"
    acl = "private"
    
    versioning {
        enabled = true
    }
}

resource "aws_dynamodb_table" "tf_statelock" {
    name = var.aws_dynamodb_table
    read_capacity = 20
    write_capacity = 20
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }    
}
