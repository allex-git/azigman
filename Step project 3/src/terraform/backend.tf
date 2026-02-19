terraform {
  required_version = ">= 1.4.0"

  backend "s3" {
    bucket  = "tf-tfstate-danit-11"
    key     = "state/allex-devops/step-project-3/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}
