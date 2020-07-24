provider "aws" {
    region= "eu-central-1"
    shared_credentials_file= "~/.aws/credentials"
    profile= "default"
}

resource "aws_s3_bucket" "Dev"{
    bucket = "super-develop-bucket"
    acl = "private"
    versioning {
    enabled = true
  }

policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1591297701977",
    "Statement": [
        {
            "Sid": "Stmt1591297700192",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::084827403662:user/super-dev"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::super-develop-bucket/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket" "Staging"{
    bucket = "super-staging-bucket"
    acl = "private"
    versioning {
    enabled = true
  }

policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1591297701977",
    "Statement": [
        {
            "Sid": "Stmt1591297700192",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::084827403662:user/super-dev"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::super-staging-bucket/*"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket" "Testing"{
    bucket = "super-testing-buck"
    acl = "private"
    versioning {
    enabled = true
  }
policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1591297701977",
    "Statement": [
        {
            "Sid": "Stmt1591297700192",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::084827403662:user/super-dev"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::super-testing-buck/*"
        }
    ]
}
POLICY
}

