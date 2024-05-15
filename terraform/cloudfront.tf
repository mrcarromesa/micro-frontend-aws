resource "aws_cloudfront_distribution" "main" {
  enabled = true
  # aliases = []
  default_root_object = "index.html"
  is_ipv6_enabled = true
  wait_for_deployment = true

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods = ["GET", "HEAD", "OPTIONS"]

    # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html#managed-cache-caching-optimized
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    target_origin_id = "${aws_s3_bucket.www_bucket.bucket}"
    
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

  }

  origin {
    domain_name = "${aws_s3_bucket.www_bucket.bucket_regional_domain_name}"
    origin_access_control_id = "${aws_cloudfront_origin_access_control.main.id}"
    origin_id = "${aws_s3_bucket.www_bucket.bucket}"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    # acm_certificate_arn = "??"
    cloudfront_default_certificate  = true
    # minimum_protocol_version        = "TLSv1.2_2021"
    # ssl_support_method              = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_control" "main" {
  name                              = "s3-cloudfront-oac-page-test"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_iam_policy_document" "cloudfront_oac_access" {
  statement {
    principals {
      identifiers = ["cloudfront.amazonaws.com"]
      type        = "Service"
    }
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.www_bucket.arn}/*"]

    condition {
      test      = "StringEquals"
      values    = ["${aws_cloudfront_distribution.main.arn}"]
      variable  = "AWS:SourceArn" 
    }
  }
}