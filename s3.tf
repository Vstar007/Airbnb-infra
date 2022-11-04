resource "aws_s3_bucket" "b" {
  bucket = "cicd-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}