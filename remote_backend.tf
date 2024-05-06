resource "aws_s3_bucket" "terraform_state"{
    bucket = "nti-remote-statefile"
    lifecycle {
        prevent_destroy = false 
  } 
  }

resource "aws_s3_bucket_versioning" "enable"{
    bucket = aws_s3_bucket.terraform_state.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "NTI-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}

