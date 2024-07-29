# Modules
module "alb" {
  source = "./alb"

  # ...
}

module "asg" {
  source = "./asg"

  # ...
}

module "ec2" {
  source = "./ec2"

  # ...
}

module "iam-policy" {
  source = "./iam-policy"

  # ...
}
module "rds" {
  source = "./rds"

  # ...
}
module "security-group" {
  source = "./security-group"

  # ...
}
module "ses" {
  source = "./ses"

  # ...
}
module "tag-policy" {
  source = "./tag-policy"

  # ...
}
module "vpc" {
  source = "./vpc"

  # ...
}
module "dev_vpc" {
  source = "./environments/dev/vpc"

  # ...
}
module "alb_asg" {
  source = "./environments/dev/alb-asg"

  # ...
}
module "ec2" {
  source = "./environments/dev"

  # ...
}




