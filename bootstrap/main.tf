resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "prod"
  }
}


#creating test bucket
# resource "aws_s3_bucket" "tf_statetest_bucket" {
#   bucket = "dummy-terraform-state-bucket-test-7104"

#   tags = {
#     Name        = "Dummy Terraform State Bucket"
#     Environment = "prod"
#   }
# }
# resource "aws_dynamodb_table" "tf_lock" {
#   name         = var.dynamodb_table
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   tags = {
#     Name        = "Terraform Locks Table"
#     Environment = "prod"
#   }
# }