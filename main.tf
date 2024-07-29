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
module "dev_vpc" {
  source = "./modules/environments/dev/vpc"

  # ...
}
module "alb_asg" {
  source = "./modules/environments/dev/alb-asg"

  # ...
}
module "ec2" {
  source = "./modules/environments/dev"

  # ...
}




