resource "aws_s3_bucket" "www_bucket" {
  bucket        =  "static-site-crm-static-page-test-1"
  force_destroy = true
  tags          =  {
    Project = "my-project"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.www_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.www_bucket.id
  policy = data.aws_iam_policy_document.cloudfront_oac_access.json
  # policy = jsonencode({
  #   Version = "2012-10-17"
  #   Statement = [
  #     {
  #       Effect    = "Allow"
  #       Principal = {
  #         Service = "cloudfront.amazonaws.com"
  #       }
  #       Action    = [
  #         "s3:GetObject"
  #       ]
  #       Resource  = [
  #         "${aws_s3_bucket.www_bucket.arn}/*"
  #       ]
  #     }
  #   ]
  # })
}