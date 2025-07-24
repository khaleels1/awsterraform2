provider "aws" {
  region     = local.region[var.env]
  

  // Use assume role for cross-account
  // This is the role that has been created in the target account
  assume_role {
    role_arn     = local.assume_role_arn
    session_name = "TerraformSession-${var.env}"
}
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.env}-bucket-7104577518"
  tags = {
    Name        = "My bucket"
    Environment = "${var.env}"
  }

}

resource "aws_vpc" "VPC" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  tags = {
    Name        = "${var.env}-VPC"
    Environment = "${var.env}"
  }
}
resource "aws_subnet" "Subnet" {
  vpc_id            = aws_vpc.VPC.id
  availability_zone = "us-east-1a"
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.env}-Subnet"
    Environment = "${var.env}"
  }
}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name        = "${var.env}-IGW"
    Environment = "${var.env}"
  }
}
resource "aws_route_table" "RouteTable" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name        = "${var.env}-RouteTable"
    Environment = "${var.env}"
  }
}
resource "aws_route_table_association" "RouteTableAssociation" {
  subnet_id      = aws_subnet.Subnet.id
  route_table_id = aws_route_table.RouteTable.id
}

resource "aws_security_group" "SG" {
  name        = "${var.env}-SG"
  description = "Security group for Dev environment"
  vpc_id      = aws_vpc.VPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.desktop_ips # Replace with your IP address
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "my_ec2_instance" {
  ami                         = "ami-020cba7c55df1f615" # Replace with a valid AMI ID
  instance_type               = var.instance_type
  availability_zone           = "${local.region[var.env]}a"
  key_name                    = "my-key-pair"
  subnet_id                   = aws_subnet.Subnet.id
  vpc_security_group_ids      = [aws_security_group.SG.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.env}-Instance"
    Env =  var.env_tag
  }

  user_data = filebase64("userdata/apache.sh") # Path to your user data script
}
resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-key-pair"
  public_key = file("~/.ssh/id_ed25519.pub") # Replace with the path to your public key
}
data "aws_caller_identity" "current" {

}
# data "aws_iam_account_alias" "current" {
# }


output "Public_IP" {
  value = aws_instance.my_ec2_instance.public_ip
}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
output "caller_user" {
  value = data.aws_caller_identity.current.user_id

}
# output "aws_iam_account_alias" {
#   value = data.aws_iam_account_alias.current.account_alias

# }