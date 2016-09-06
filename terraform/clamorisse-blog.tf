variable "aws-region"          { }
variable "application-name"    { }
variable "bucket-name"         { }
variable "env"                 { }

# Provider defaults settings
provider "aws" {
  region = "${var.aws-region}"
  profile = "${var.profile-name}"
}

resource "aws_s3_bucket" "blog-bucket" {
    bucket = "${var.bucket-name}"
    //acl = "public-read"
    force_destroy = "true"
    policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid": "AddPerm",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "S3:GetObject",
      "Resource": "arn:aws:s3:::${var.bucket-name}/*"
    }
  ]
}
EOF

    website {
        index_document  = "index.html"
        error_document  = "error.html"
    }

    tags {
        Name            = "${var.bucket-name}"
        Env             = "${var.env}"
    }
}

module "iam-user" {
  source = "github.com/clamorisse/modular-terraform-automation//modules/iam/users"

  user_names = "${var.application-name}-deployuser-${var.env}"
}

resource "aws_iam_user_policy" "blog-s3-deployment-policy" {
    name = "${var.application-name}-policydeploy-${var.env}"
    user = "${module.iam-user.users}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetBucketLocation",
        "s3:ListAllMyBuckets"
      ],
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": "arn:aws:s3:::${var.bucket-name}"
    },
    {
      "Action": [
         "s3:PutObject",
         "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.bucket-name}/*" 
    }
  ]
}
EOF
}

