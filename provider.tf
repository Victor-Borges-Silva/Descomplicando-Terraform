terraform {
  #  backend "s3" {
  #    bucket         = "descomplicando-terraform-turma-2024" #nome do bucket
  #    key            = "aula_backend"
  #    region         = "us-east-1"
  #  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.58.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}