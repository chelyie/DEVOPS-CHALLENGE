terraform {
    required_required_providers{
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws {
    region = "us-east-1"
}

    resource "aws_s3_bucket" "terraform_state" {
        bucket = "master-devops" #replace with your bucket name 
        force_destroy = true
        versioning {
            enabled = true 
        }

        server_side_encryption_configuration {
            rule {
                apply_server_side_encryption_by_default {
                    sse_algorithm = "AES256"
                }
            }
        }
    }

    resource "aws_dynamodb_table" "terraform_locks" {
        name         = "terraform-state-locking"
        billing_mode ="PAY_PER_REQUEST"
        hask_key     = "LockID"
        attributes {
            name = "LockID"
            type = "S"
        }
    }