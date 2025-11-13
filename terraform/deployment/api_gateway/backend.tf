terraform {
  backend "s3" {
    bucket  = "microservices-terraform-state-10-nov"
    key     = "api_service/terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
  }
}

#
