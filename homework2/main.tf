provider "aws" {
    region = "us-east-1"
}
resource "aws_key_pair" "Bastion-key" {
    key_name   = "Bastion-key"
    public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_s3_bucket" "bucket-1" {
    bucket = "kaizen-amandakalybek"
}

resource "aws_s3_bucket" "bucket-2" {
    bucket = "blablablakaizen"
}

resource "aws_s3_bucket" "bucket-manual1" {     #terraform import aws_s3_bucket.bucket-manual1 kaizenicantchosename
    bucket = "kaizenicantchosename"
}

resource "aws_s3_bucket" "bucket-manual2" {     #terraform import aws_s3_bucket.bucket-manual2 kaizensohardtochosename
    bucket = "kaizensohardtochosename"
}

variable "user_names" {
    type = list(string)
    default = ["lisa", "jennie", "jisoo", "rose"]
}

resource "aws_iam_user" "iam_users" {
  for_each = toset(var.user_names)
  name = each.key
}

resource "aws_iam_group" "blackpink" {
  name = "blackpink"
}

resource "aws_iam_user_group_membership" "blackpink_in_your_area" {
    for_each = toset(var.user_names)
    user = aws_iam_user.iam_users[each.key].name
    groups = [aws_iam_group.blackpink.name]
}