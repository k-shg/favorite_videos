provider "aws" {
  region  = "ap-northeast-1"
  profile = "prd-favorite-videos"
}


resource "aws_s3_bucket" "tfstate" {
  bucket = "bkt-terraform"
}

terraform {
  backend "s3" {
    region  = "ap-northeast-1"
    bucket = "bkt-terraform"
    key = "terraform.tfstate"
    profile = "prd-favorite-videos"
  }
}
