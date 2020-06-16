# Terraform AWS S3 remote backend

Creates a unique AWS Simple Storage Service (S3) bucket for storing the Terraform remote state file. Also stands-up an AWS DynamoDB table to allow for state locking.

## Quickstart

1) Create the initial S3 bucket, with the state file being stored locally
```
terraform init
terraform apply
```

2) Move the local state file to the remote S3 backend just created. Do this by adding the following to the top of the `main.tf` file. The BUCKET_NAME and REGION are outputs from the `terraform apply` from the previous step:
```
terraform {
    backend "s3" {
        bucket  = "BUCKET_NAME"
        region  = "REGION"
        key     = "global/s3/terraform.tfstate"
        encrypt = true
    }
}
```

3) Run:
```
terraform init
```
and agree to copy the local state file: (i.e. `yes`)

4) Run `terraform plan` to ensure we do not need to recreate the S3 bucket after the state file migration.

5) Use this `terraform` section from step (2) in any other files you wish to use this S3 bucket for remote state storage with a new `key` value that specifies the state file path in the bucket.
