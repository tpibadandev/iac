terraform {
  required_version = "~> 1.4"

  backend "s3" {
    key    = "github-actions-iaac-apache/terraform.tfstate" # the directory/file.tfstate
    bucket = "polyiabucket"             # the bucket
    region = "us-east-1"             # the region
  }
}