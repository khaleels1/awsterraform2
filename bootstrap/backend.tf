terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-prod-7104"
    key            = "dev/network/terraform.tfstate"   # uniquely identifies state per environment/module
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-prod-7104"
    encrypt        = true
  }
}