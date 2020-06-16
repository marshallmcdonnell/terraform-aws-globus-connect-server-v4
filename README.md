# Terraform Globus Connect Server on AWS EC2
Provision a Globus Connect Server on AWS EC2 instance for an Ubuntu OS

## Quickstart

0) [Install terraform](https://learn.hashicorp.com/terraform/getting-started/install)
1) Clone this repo
2) Setup a way to authenicate with AWS via Terraform's [AWS provider docs](https://www.terraform.io/docs/providers/aws/index.html)
3) Setup the remote backend for an AWS S3 via the [`backend`](https://github.com/marshallmcdonnell/terraform-aws-globus-connect-server/tree/master/backend) directory, instructions in README.
4) Back at the top-level of this repository, initialize: `terraform init`
5) Review and apply changes to resources: `terraform apply`
6) Tear down resources: `terraform destroy`
