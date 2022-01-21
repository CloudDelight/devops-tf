#############Create S3 Bucket #######

resource "aws_s3_bucket" "lifecycle-testing" {
  bucket = "lifecycle-testing12345"
  acl    = "private"
}

########### Create Two Folders inside the S3 bucket created ###########
resource "aws_s3_bucket_object" "lifecycle-testing-prod" {
  bucket = "${aws_s3_bucket.lifecycle-testing.id}"
  acl    = "private"
  key    = "prod/"
  source = "/dev/null"
}

resource "aws_s3_bucket_object" "lifecycle-testing-prod-archive" {
  bucket = "${aws_s3_bucket.lifecycle-testing.id}"
  acl    = "private"
  key    = "archive/"
  source = "/dev/null"
}

################# Enable life cycle policy for s3 Bucket objects ##########

resource "aws_s3_bucket" "lifecycle-testing" {
  bucket = "lifecycle-testing12345"
  acl    = "private"

  lifecycle_rule {
    id      = "archive"
    enabled = true

    prefix = "archive/"

    tags {
      "rule" = "archive"
    }

    transition {
      days          = 30
      storage_class = "ONEZONE_IA"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 120
    }
  }
}

############ S3 lifecycle rule ###########
