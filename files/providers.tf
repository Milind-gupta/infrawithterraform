terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}


provider "aws" {
  profile = "default"
  region  = "ap-south-1"
  access_key = "AKIA4DLWACUGL2AHMV7C"
  secret_key = "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"

}

