# Modules
module "alb-asg" {
  source = "./apps/alb-asg/.terraform/modules"

  # ...
}

module "asg" {
  source = "./modules/asg"

  # ...
}
module "alb" {
  source = "./modules/alb"

  # ...
}

module "ec2" {
  source = "./apps/ec2"

  # ...
}

module "iam-policy" {
  source = "./modules/iam-policy"

  # ...
}
module "rds" {
  source = "./infra/rds"

  # ...
}
module "security-group" {
  source = "./modules/security-group"

  # ...
}
module "ses" {
  source = "./infra/ses"

  # ...
}

module "route53" {
  source = "./infra/route53"

  # ...
}
module "tag-policy" {
  source = "./infra/tag-policy"

  # ...
}
module "vpc" {
  source = "./infra/vpc"

  # ...
}
module "acm" {
  source = "./environments/dev/acm"

  # ...
}
module "vars" {
  source = "./vars/dev/"

  # ...
}





