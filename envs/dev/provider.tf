provider "aws" {
  region = "us-east-1"

  # assume_role {
  #   role_arn     = "arn:aws:iam::914831943887:role/TerraformExecutionRole"
  #   session_name = "TerraformSession-dev"
  # }
    assume_role {
    role_arn     = local.assume_role_arn
    session_name = "TerraformSession-${var.env}"
}
}