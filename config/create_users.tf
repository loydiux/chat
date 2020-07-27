provider "aws" {
    region= "eu-central-1"
    access_key = "AWS_ACCESS_KEY_ID"
    secret_key = "AWS_SECRET_ACCESS_KEY"
}


resource "aws_iam_group_membership" "team" {
  name = "s3-admin"

  users = [
    "${aws_iam_user.dev.name}",
    "${aws_iam_user.prod.name}",
  ]

  group = aws_iam_group.s3_group.name
}


data "aws_iam_policy" "policy" {
 arn= "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_group" "s3_group" {
  name = "s3-access"
    path = "/users/"
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  groups = [aws_iam_group.s3_group.name]
  policy_arn = "${data.aws_iam_policy.policy.arn}"
}

resource "aws_iam_user" "dev" {
  name = "super-dev"
}

resource "aws_iam_user" "prod" {
  name = "super-prod"
}
