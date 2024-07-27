data "aws_caller_identity" "id" {}

locals {
  tags = {
    Name        = var.name
    Environment = var.env
    Designation          = "${var.name}-${var.env}"
    Terraform   = true
  }
}