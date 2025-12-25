variable "region" { default = "ap-northeast-1" }
variable "name"   { default = "three-tier" }

variable "vpc_cidr" { default = "10.0.0.0/16" }

variable "azs" {
  default = ["ap-northeast-1a", "ap-northeast-1c"]
}

variable "public_subnet_cidrs" {
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_app_subnet_cidrs" {
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "private_db_subnet_cidrs" {
  default = ["10.0.20.0/24", "10.0.21.0/24"]
}

variable "app_port" { default = 8080 }
variable "instance_type" { default = "t3.micro" }

variable "db_username" { default = "appuser" }
variable "db_password" {
  sensitive = true
}
