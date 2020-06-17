# Terraform Globus Connect Server on AWS EC2
Provision a Globus Connect Server on AWS EC2 instance for a RHEL AMI

## Quickstart

0) [Install terraform](https://learn.hashicorp.com/terraform/getting-started/install)
1) Clone this repo
2) Setup a way to authenicate with AWS via Terraform's [AWS provider docs](https://www.terraform.io/docs/providers/aws/index.html)
3) Setup the remote backend for an AWS S3 via the [`backend`](https://github.com/marshallmcdonnell/terraform-aws-globus-connect-server/tree/master/backend) directory, instructions in README.
4) Back at the top-level of this repository, initialize: `terraform init`
5) Create a `tfvars` file to hold the Globus User credentials for the endpoint (sample file included to copy from in `terraform.tfvars.sample`). Easiest is to just:
```
cp terraform.tfvars.sample terraform.tfvars
```
and modify the file for your `GLOBUS_USER` and `GLOBUS_PASSWORD` 

6) Review and apply changes to resources: `terraform apply -var-file=terraform.tfvars`
7) Tear down resources: `terraform destroy -var-file=terraformtfvars`
