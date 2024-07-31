# Modules
module "alb-asg" {
  source = "./apps/alb-asg/.terraform/modules"
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
    #IAM Policy
iam_policy_json_file        = "ec2.json"

# EC2 Instance Variables
region         = "us-west-2"
ami_id         = "ami-0e8ffa060937e44c7"
instance_type  = "t2.micro"
key_name       = "techiescamp"
instance_count = 1
subnet_ids     = ["subnet-034b5b81e1ee5e653", "subnet-0bfbbe8efe880be15", "subnet-059ad803aa3c5d9c5"]
associate_public_ip_address = true
attach_instance_profile     = true
attach_eip                  = false
storage_size                = 30

# EC2 Security Group Variables
vpc_id  = "vpc-062e91b98392ca9a2"

# Tag Keys
owner       = "techiescamp"
environment = "test"
cost_center = "techiescamp-commerce"
application = "jenkins-agent"

# CIDR Ingress Variables
create_ingress_cidr    = true
ingress_cidr_from_port = [22, 8080]
ingress_cidr_to_port   = [22, 8080]
ingress_cidr_protocol  = ["tcp", "tcp"]
ingress_cidr_block     = ["0.0.0.0/0", "0.0.0.0/0"]

# Security Group Ingress Variables
create_ingress_sg          = false
ingress_sg_from_port       = [80]
ingress_sg_to_port         = [80]
ingress_sg_protocol        = ["tcp"]
ingress_security_group_ids = ["sg-0fe4363da3994c100"]

# CIDR Egress Variables
create_egress_cidr    = true
egress_cidr_from_port = [0]
egress_cidr_to_port   = [0]
egress_cidr_protocol  = ["-1"]
egress_cidr_block     = ["0.0.0.0/0"]

# Security Group Egress Variables
create_egress_sg          = false
egress_sg_from_port       = [0]
egress_sg_to_port         = [0]
egress_sg_protocol        = ["-1"]
egress_security_group_ids = ["sg-0fe4363da3994c100"]
  # ...
}

module "iam-policy" {
  source = "./modules/iam-policy"

  # ...
}
module "rds" {
  source = "./infra/rds"
  # Network Vars
region              = "us-west-2"
subnet_ids          = ["subnet-058a7514ba8adbb07", "subnet-0dbcd1ac168414927", "subnet-032f5077729435858"]
multi_az            = false
publicly_accessible = true

# DB Vars
db_engine                   = "mysql"
db_storage_type             = "gp2"
db_username                 = "techiescamp"
db_instance_class           = "db.t2.micro"
db_storage_size             = 20
set_secret_manager_password = true
set_db_password             = false
db_password                 = "rdssecret"

# Security Group Vars
from_port  = 3306
to_port    = 3306
protocol   = "tcp"
cidr_block = ["0.0.0.0/0"]

# Backup vars
backup_retention_period  = 7
delete_automated_backups = true
copy_tags_to_snapshot    = true
skip_final_snapshot      = true
apply_immediately        = true

# Tag Vars
owner       = "techiescamp-devops"
environment = "dev"
cost_center = "techiescamp"
application = "techiescamp-commerce"
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
    #SES variables
region            = "us-west-2"
domain_name       = "thepolytechnicibadan.dev"
dkim_record_count = 3
zone_id           = "Z044775511DCQ7IHFO1WH"
dkim_record_type  = "CNAME"
dkim_ttl          = "1800"
custom_mail       = "email"
spf_mx_record     = "MX"
spf_txt_record    = "TXT"
spf_ttl           = "300"

# Tag Keys
name        = ""
owner       = "polyibadan"
environment = ""
cost_center = "polyibadan-commerce"
application = "pet-clinic"
  # ...
}

module "route53" {
  source = "./infra/route53"
    region = "us-west-2"

dns_domain_name = "thepolytechnicibadan.dev"

# Tag Keys
name        = ""
owner       = "polyibadan"
environment = "dev"
cost_center = "polyibadan-commerce"
application = "route53"
  # ...
}
module "tag-policy" {
  source = "./infra/tag-policy"
  # Tag Policy Vars
region      = "us-west-2"
policy_name = "Techiescamp"
policy_type = "TAG_POLICY"
target_id   = "814200988517"

name_tag_key         = "Name"
environment_tag_key  = "Environment"
owner_tag_key        = "Owner"
owner_tag_value      = ["techiescamp"]
costcenter_tag_key   = "CostCenter"
costcenter_tag_value = ["techiescamp-commerce"]
application_tag_key  = "Application"
enforce_for_values = ["dynamodb:*", "ec2:dhcp-options", "ec2:elastic-ip", "ec2:fpga-image", "ec2:instance",
  "ec2:internet-gateway", "ec2:launch-template", "ec2:natgateway", "ec2:network-acl",
  "ec2:network-interface", "ec2:route-table", "ec2:security-group", "ec2:snapshot",
  "ec2:subnet", "ec2:volume", "ec2:vpc", "ec2:vpc-endpoint", "ec2:vpc-endpoint-service",
  "ec2:vpc-peering-connection", "ec2:vpn-connection", "ec2:vpn-gateway", "elasticfilesystem:*",
  "elasticloadbalancing:*", "iam:instance-profile", "iam:mfa", "iam:policy", "kms:*",
  "lambda:*", "rds:cluster-pg", "rds:cluster-endpoint", "rds:es", "rds:og", "rds:pg", "rds:db-proxy",
  "rds:db-proxy-endpoint", "rds:ri", "rds:secgrp", "rds:subgrp", "rds:target-group", "resource-groups:*",
"route53:hostedzone", "s3:bucket", "s3:bucket"]
  # ...
}
module "vpc" {
  source = "./infra/vpc"
    #vpc
region               = "us-west-2"
vpc_cidr_block       = "10.0.0.0/16"
instance_tenancy     = "default"
enable_dns_support   = true
enable_dns_hostnames = true

#elastic ip
domain = "vpc"

#nat-gateway
create_nat_gateway = true

#route-table
destination_cidr_block = "0.0.0.0/0"

#tags
owner       = "techiescamp"
environment = "dev"
cost_center = "techiescamp-commerce"
application = "ecommerce"


map_public_ip_on_launch       = true

#subnets
public_subnet_cidr_blocks     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
app_subnet_cidr_blocks        = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
db_subnet_cidr_blocks         = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
management_subnet_cidr_blocks = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
platform_subnet_cidr_blocks   = ["10.0.13.0/24", "10.0.14.0/24", "10.0.15.0/24"]

# Availability Zones
availability_zones            = ["us-west-2a", "us-west-2b", "us-west-2c"]


#Public Subnet NACL
ingress_public_nacl_rule_no    = [100]
ingress_public_nacl_action     = ["allow"]
ingress_public_nacl_from_port  = [0]
ingress_public_nacl_to_port    = [0]
ingress_public_nacl_protocol   = ["-1"]
ingress_public_nacl_cidr_block = ["0.0.0.0/0"]

egress_public_nacl_rule_no    = [200]
egress_public_nacl_action     = ["allow"]
egress_public_nacl_from_port  = [0]
egress_public_nacl_to_port    = [0]
egress_public_nacl_protocol   = ["-1"]
egress_public_nacl_cidr_block = ["0.0.0.0/0"]

#app nacl
ingress_app_nacl_rule_no    = [100]
ingress_app_nacl_action     = ["allow"]
ingress_app_nacl_from_port  = [0]
ingress_app_nacl_to_port    = [0]
ingress_app_nacl_protocol   = ["-1"]
ingress_app_nacl_cidr_block = ["0.0.0.0/0"]

egress_app_nacl_rule_no    = [200]
egress_app_nacl_action     = ["allow"]
egress_app_nacl_from_port  = [0]
egress_app_nacl_to_port    = [0]
egress_app_nacl_protocol   = ["-1"]
egress_app_nacl_cidr_block = ["0.0.0.0/0"]

##db nacl
ingress_db_nacl_rule_no    = [100]
ingress_db_nacl_action     = ["allow"]
ingress_db_nacl_from_port  = [0]
ingress_db_nacl_to_port    = [0]
ingress_db_nacl_protocol   = ["-1"]
ingress_db_nacl_cidr_block = ["0.0.0.0/0"]

egress_db_nacl_rule_no    = [200]
egress_db_nacl_action     = ["allow"]
egress_db_nacl_from_port  = [0]
egress_db_nacl_to_port    = [0]
egress_db_nacl_protocol   = ["-1"]
egress_db_nacl_cidr_block = ["0.0.0.0/0"]

##management nacl
ingress_management_nacl_rule_no    = [100]
ingress_management_nacl_action     = ["allow"]
ingress_management_nacl_from_port  = [0]
ingress_management_nacl_to_port    = [0]
ingress_management_nacl_protocol   = ["-1"]
ingress_management_nacl_cidr_block = ["0.0.0.0/0"]

egress_management_nacl_rule_no    = [200]
egress_management_nacl_action     = ["allow"]
egress_management_nacl_from_port  = [0]
egress_management_nacl_to_port    = [0]
egress_management_nacl_protocol   = ["-1"]
egress_management_nacl_cidr_block = ["0.0.0.0/0"]

#platform nacl
ingress_platform_nacl_rule_no    = [100]
ingress_platform_nacl_action     = ["allow"]
ingress_platform_nacl_from_port  = [0]
ingress_platform_nacl_to_port    = [0]
ingress_platform_nacl_protocol   = ["-1"]
ingress_platform_nacl_cidr_block = ["0.0.0.0/0"]

egress_platform_nacl_rule_no    = [200]
egress_platform_nacl_action     = ["allow"]
egress_platform_nacl_from_port  = [0]
egress_platform_nacl_to_port    = [0]
egress_platform_nacl_protocol   = ["-1"]
egress_platform_nacl_cidr_block = ["0.0.0.0/0"]

#endpoint
create_s3_endpoint              = true
create_secrets_manager_endpoint = true
create_cloudwatch_logs_endpoint = true

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





