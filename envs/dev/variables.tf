variable "env" {
  description = "Deployment environment"
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
variable "env_tag" {
  description = "Tag for the environment"
  type        = string
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}
variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}
variable "public_ssh_key" {
  description = "SSH key for public access"
  type        = string  
}

variable "desktop_ips" {
  description = "List of desktop IPs allowed to access the resources"
  type        = list(string)
  default     = ["74.67.40.36/32"]  # use comma-separated values for multiple IPs
}

locals {
  account_map = {
    dev     = "914831943887"
    nonprod = "221611098716"
    prod    = "744260985733"
  }

  region = {
    dev     = "us-east-1"
    nonprod = "us-east-1"
    prod    = "us-east-1"
  }

  assume_role_arn = "arn:aws:iam::${local.account_map[var.env]}:role/CrossAccountAdminRole"
}