  variable "bucket_name" {
    description = "value for the bucket name used for storing Terraform state"
    type = string
    default = "terraform-state-bucket-prod-7104"
  }
   variable "dynamodb_table" {
    description = "value for the DynamoDB table name used for Terraform state locking"
    type = string
    default = "terraform-locks-prod-7104"     
   }
