variable "region" { default = "ap-northeast-1" }
variable "name" { default = "mix-three-tier" }
variable "asg_name" { default = "mix-three-tier-asg" }

variable "vpc_cidr" { default = "10.0.0.0/16" }

variable "azs" {
  default = ["ap-northeast-1a", "ap-northeast-1d", "ap-northeast-1c"]
}

variable "public_subnet_cidrs" {
  default = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_app_subnet_cidrs" {
  default = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
}

variable "private_db_subnet_cidrs" {
  default = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]
}

variable "app_port" { default = 8080 }
# m6g.large
variable "instance_type" { default = "t3.micro" }

variable "s3_bucket_arn" { default = "arn:aws:s3:::smm-sandbox-3tier-architecture" }

variable "db_engine" { default = "mysql" }
# db.m6g.large
variable "db_instance_class" { default = "db.t4g.micro" }

variable "db_username" { default = "mixuser" }
variable "db_password" {
  sensitive = true
}



