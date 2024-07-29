# Modules
module "alb" {
  source = "./modules/alb"

  # ...
}

module "asg" {
  source = "./modules/asg"

  # ...
}

module "ec2" {
  source = "./modules/ec2"

  # ...
}

module "iam-policy" {
  source = "./modules/iam-policy"

  # ...
}
module "rds" {
  source = "./modules/rds"

  # ...
}
module "security-group" {
  source = "./modules/security-group"

  # ...
}
module "ses" {
  source = "./modules/ses"

  # ...
}
module "tag-policy" {
  source = "./modules/tag-policy"

  # ...
}
module "vpc" {
  source = "./modules/vpc"

  # ...
}
module "acm" {
  source = "./environments/dev/acm"

  # ...
}





