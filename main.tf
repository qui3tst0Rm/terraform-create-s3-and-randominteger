provider "aws" {
  region = var.region[terraform.workspace]
}

#################################################################
#                      Random Integer                           #  
#################################################################
resource "random_integer" "bucket_int" {
  min = 10000
  max = 99999
}

#################################################################
#                Simple Storage Service (S3)                    #  
#################################################################
data "aws_canonical_user_id" "current_user" {}

resource "aws_s3_bucket" "s3-rand-int" {
    bucket = local.s3_bucket_name_rand_int
    #acl = "private"
    force_destroy = true

    grant {
      id = data.aws_canonical_user_id.current_user.id
      type = "CanonicalUser"
      permissions = ["FULL_CONTROL"]
    }
}

#################################################################
#                    S3 - Block Pub Access                      #  
#################################################################

resource "aws_s3_bucket_public_access_block" "s3-rand-int" {
  bucket = aws_s3_bucket.s3-rand-int.id
  block_public_acls = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true

}