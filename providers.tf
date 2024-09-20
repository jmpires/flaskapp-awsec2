
terraform {
  required_version = ">= 1.5.1, < 1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.12"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}

# Using remote backend
terraform {
  backend "s3" {
    bucket = "my-backend-devops101-terraform"
    key    = "flaskappawsec2/tfstate"
    region = "us-east-1"
  }
}