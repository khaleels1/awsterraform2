terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

# backend "s3" {
#   bucket         = "terraform-state-bucket-prod-7104"
#   key            = "envs/dev/terraform/state"
#   region         = "us-east-1"
#   dynamodb_table = "terraform-locks-prod-7104"
# }
}
