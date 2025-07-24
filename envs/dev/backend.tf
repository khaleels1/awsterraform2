terraform {
  backend "s3" {
    bucket         = "terraform-state-prod-7104"             # in Prod account
    key            = "dev/vpc/terraform.tfstate"             # change this per env/module
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-prod-7104"             # in Prod account
    encrypt        = true
  }
}