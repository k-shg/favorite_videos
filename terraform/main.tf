provider "aws" {
  region  = "ap-northeast-1"
  profile = "my-profile"
}


resource "aws_s3_bucket" "tfstate" {
  bucket = "bkt-terraform"
}
