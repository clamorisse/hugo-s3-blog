# -----------------------------------------------
#       GLOBAL INFRASTRUCTURE FOR BLOG
#                 HOSTED IN S3
# ----------------------------------------------

variable "bucket-name"         { }
variable "env"                 { }

# CREATE BUCKET IN S3

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
      "Action": [
        "S3:GetObject",
        "S3:PutObject"
      ],
      "Resource": "arn:aws:s3:::${var.bucket-name}/*"
    },
    {
      "Sid": "AddPermissions",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "S3:ListBucket",
      "Resource": "arn:aws:s3:::bvcblog.cotero.org"
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

output "website_endpoint" {
  value = "${var.bucket-name}.${aws_s3_bucket.blog-bucket.website_domain}"
}

