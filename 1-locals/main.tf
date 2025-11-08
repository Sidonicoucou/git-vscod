# This is my first code with git in vscode
provider "aws" {
  profile = "default"
  region = "us-east-1"
}

 locals {
   test-tags = {
     team = "devop"
     env = "test"
     name = "Tomcat"
   }
}

resource "aws_instance" "web" {
  ami           = "ami-0dbc3d7bc646e8516"
  instance_type = "t2.micro"

  tags = local.test-tags
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
