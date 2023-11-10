provider "aws" {
  profile = "default"
  region = "us-east-1"
}

# provider "aws" {
#   region = "us-east-1"
#   access_key = "AKIAZW6Q42G64VTBDG2Z"
#   secret_key = "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"
# }

 locals {
   test-tags = {
     team = "devop"
     env = "test"
   }
}

resource "aws_instance" "web" {
  ami           = "ami-0dbc3d7bc646e8516"
  instance_type = "t2.micro"

  tags = local.test-tags
}

resource "aws_iam_user" "test-user" {
  name = "mysthreeuser"
  path = "/"

  tags = {
    Name = "mysthreeuser"
    account = "finance"
  }
}

resource "aws_iam_access_key" "test-key" {
  user    = aws_iam_user.test-user.name
}

data "aws_iam_policy" "user-policy" {
  name = "list-bucket-policy"
}

resource "aws_iam_policy_attachment" "test-sss" {
  name       = "sss-attachment"
  users      = [aws_iam_user.test-user.name]
  policy_arn = data.aws_iam_policy.user-policy.arn 
}

output "sss-user" {
  description = "export the unique-id of user"
  value =aws_iam_user.test-user.unique_id

}
