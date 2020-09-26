#################################################################
#                         Variables                             #  
#################################################################
variable "region" {}

variable "project" {}

#################################################################
#                         locals                                #  
#################################################################
locals {
    env_name = lower(terraform.workspace)

    common_tags = {
      Project     = var.project
      Environment = local.env_name
    }

    s3_bucket_name_rand_int = "${local.common_tags.Project}-${random_integer.bucket_int.result}-bucket"
}


