terraform {
  backend "s3" {
    bucket  = "microservices-terraform-state-10-nov"
    key     = "path/to/my/terraform.tfstate"
    region  = "eu-north-1"
    encrypt = true
  }
}
