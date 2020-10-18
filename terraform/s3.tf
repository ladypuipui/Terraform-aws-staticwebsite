# S3

resource "aws_s3_bucket" "site" {
  bucket = "${var.bucket_name}"
  acl = "private"
}

resource "aws_s3_bucket_policy" "site" {
  bucket = "${aws_s3_bucket.site.id}"
  policy = "${data.aws_iam_policy_document.s3_site_policy.json}"
}

data "aws_iam_policy_document" "s3_site_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.site.iam_arn}"]
    }
  }
}


# S3<cloudront log>

resource "aws_s3_bucket" "log" {
  bucket = "${var.logbucket_name}"
  acl = "private"
}
