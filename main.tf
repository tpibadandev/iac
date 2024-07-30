# Modules
module "alb-asg" {
  source = "./apps/alb-asg"

  # ...
}

module "asg" {
  source = "./modules/asg"

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
module "sg" {
  source = "./infra/sg"

  # ...
}
module "route53" {
  source = "./modules/route53"

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





