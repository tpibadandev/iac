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

  region                           = "us-east-2"

# alb
internal                       = false
loadbalancer_type              = "application"
alb_subnets                    = ["subnet-058a7514ba8adbb07", "subnet-0dbcd1ac168414927", "subnet-032f5077729435858"]

#alb-sg
alb_ingress_cidr_from_port     = [80]
alb_ingress_cidr_to_port       = [80]
alb_ingress_cidr_protocol      = ["tcp"]
alb_ingress_cidr_block         = ["0.0.0.0/0"]
alb_create_ingress_cidr        = true

alb_ingress_sg_from_port       = [8080]
alb_ingress_sg_to_port         = [8080]
alb_ingress_sg_protocol        = ["tcp"]
alb_create_ingress_sg          = false

alb_egress_cidr_from_port      = [0]
alb_egress_cidr_to_port        = [0]
alb_egress_cidr_protocol       = ["-1"]
alb_egress_cidr_block          = ["0.0.0.0/0"]
alb_create_egress_cidr         = true

alb_egress_sg_from_port        = [0]
alb_egress_sg_to_port          = [0]
alb_egress_sg_protocol         = ["-1"]
alb_create_egress_sg           = false

# instance sg
ingress_cidr_from_port         = [22]
ingress_cidr_to_port           = [22]
ingress_cidr_protocol          = ["tcp"]
ingress_cidr_block             = ["0.0.0.0/0"]
create_ingress_cidr            = true

ingress_sg_from_port           = [8080]
ingress_sg_to_port             = [8080]
ingress_sg_protocol            = ["tcp"]
create_ingress_sg              = true

egress_cidr_from_port          = [0]
egress_cidr_to_port            = [0]
egress_cidr_protocol           = ["-1"]
egress_cidr_block              = ["0.0.0.0/0"]
create_egress_cidr             = true

egress_sg_from_port            = [8080]
egress_sg_to_port              = [8080]
egress_sg_protocol             = ["tcp"]
create_egress_sg               = false

# target_group
target_group_port              = 8080
target_group_protocol          = "HTTP"
target_type                    = "instance"
load_balancing_algorithm       = "round_robin"

# health_check
health_check_path               = "/"
health_check_port               = 8080
health_check_protocol           = "HTTP"
health_check_interval           = 30
health_check_timeout            = 5
health_check_healthy_threshold  = 2
health_check_unhealthy_threshold= 2

#alb_listener
listener_port                   = 80
listener_protocol               = "HTTP"
listener_type                   = "forward"

#launch_template
ami_id                           = "ami-028ead5d254a1113d"
instance_type                    = "t2.micro"
key_name                         = "techiescamp"
vpc_id                           = "vpc-0a5ca4a92c2e10163"
asg_subnets                      = ["subnet-058a7514ba8adbb07", "subnet-0dbcd1ac168414927", "subnet-032f5077729435858"]
public_access                    = true

#user_data
user_data                        = <<-EOF
                                    #!/bin/bash
                                    bash /home/ubuntu/start.sh
                                   EOF

#autoscaling_group
max_size                         = 2
min_size                         = 1
desired_capacity                 = 1
propagate_at_launch              = true
instance_warmup_time             = 30
target_value                     = 50

#tags
owner                            = "techiescamp"
environment                      = "dev"
cost_center                      = "techiescamp-commerce"
application                      = "java-app"



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
      variable "region" {
    type        = string
    description = "Region of the security group."
  }

  variable "sg_name" {
    type        = string
    description = "Name of the security group for the instance."
  }

  variable "vpc_id" {
    type        = string
    description = "ID of the VPC associated with the security group."
  }

  variable "tags" {
    default     = {}
    type        = map(string)
    description = "Extra tags to attach to the EC2 security group resources."
  }

  variable "name" {
    type        = string
    description = "The name of the resources."
  }

  variable "environment" {
    type        = string
    description = "The environment name for the resources."
  }

  variable "owner" {
    type        = string
    description = "Owner's name for the resource."
  }

  variable "cost_center" {
    type        = string
    description = "Cost center identifier for the resource."
  }

  variable "application" {
    type        = string
    description = "Name of the application related to the resource."
  }

  variable "ingress_cidr_from_port" {
    type        = list(number)
    description = "List of starting ports for cidr ingress rules of the EC2 security group."
  }

  variable "ingress_cidr_to_port" {
    type        = list(number)
    description = "List of ending ports for cidr ingress rules of the EC2 security group."
  }

  variable "ingress_cidr_protocol" {
    type        = list(string)
    description = "List of protocols for cidr ingress rules of the EC2 security group."
  }

  variable "ingress_cidr_block" {
    type        = list(string)
    description = "List of CIDR blocks for cidr ingress rules of the EC2 security group."
  }

  variable "ingress_sg_from_port" {
    type        = list(number)
    description = "List of starting ports for sg ingress rules of the EC2 security group."
  }

  variable "ingress_sg_to_port" {
    type        = list(number)
    description = "List of ending ports for sg ingress rules of the EC2 security group."
  }

  variable "ingress_sg_protocol" {
    type        = list(string)
    description = "List of protocols for sg ingress rules of the EC2 security group."
  }

  variable "ingress_security_group_ids" {
    type        = list(string)
    description = "List of Security Group ids for sg ingress rules of the EC2 security group."
  }

  variable "egress_cidr_from_port" {
    type        = list(number)
    description = "List of starting ports for cidr egress rules of the EC2 security group."
  }

  variable "egress_cidr_to_port" {
    type        = list(number)
    description = "List of ending ports for cidr egress rules of the EC2 security group."
  }

  variable "egress_cidr_protocol" {
    type        = list(any)
    description = "List of protocols for cidr egress rules of the EC2 security group."
  }

  variable "egress_cidr_block" {
    type        = list(string)
    description = "List of CIDR blocks for cidr egress rules of the EC2 security group."
  }

  variable "egress_sg_from_port" {
    type        = list(number)
    description = "List of starting ports for sg egress rules of the EC2 security group."
  }

  variable "egress_sg_to_port" {
    type        = list(number)
    description = "List of ending ports for sg egress rules of the EC2 security group."
  }

  variable "egress_sg_protocol" {
    type        = list(any)
    description = "List of protocols for sg egress rules of the EC2 security group."
  }

  variable "egress_security_group_ids" {
    type        = list(string)
    description = "List of Security Group ids for sg egress rules of the EC2 security group."
  }

  variable "create_ingress_cidr" {
    type        = bool
    description = "Enable or disable CIDR block ingress rules."
  }

  variable "create_ingress_sg" {
    type        = bool
    description = "Enable or disable Security Groups ingress rules."
  }

  variable "create_egress_cidr" {
    type        = bool
    description = "Enable or disable CIDR block egress rules."
  }

  variable "create_egress_sg" {
    type        = bool
    description = "Enable or disable Security Groups egress rules."
  }
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
  region = "us-west-2"

  domain_name                                 = "prom.devopsproject.dev"
  validation_method                           = "DNS"
  key_algorithm                               = "RSA_2048"
  certificate_transparency_logging_preference = "ENABLED"
  dns_domain_name                             = "devopsproject.dev"

  # Tag Keys
  name        = ""
  owner       = "techiescamp"
  environment = "dev"
  cost_center = "techiescamp-commerce"
  application = "acm"

  # ...
}





