resource "aws_s3_bucket" "b" {
  bucket = $var.s3_bucket_name

  tags = {
    Name        = $var.tagname
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}
