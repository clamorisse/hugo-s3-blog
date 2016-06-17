variable "aws-region"          { }
variable "application-name"    { }
variable "policy-name"         { }
variable "iam-name"            { }
variable "bucket-name"         { }
variable "env"                 { }

# Provider defaults settings
provider "aws" {
  region = "${var.aws-region}"
  profile = "default"
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

