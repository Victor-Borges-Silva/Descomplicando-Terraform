terraform {
  #  backend "s3" {
  #    bucket = "descomplicando-terraform-turma-2024-vborges" #nome do bucket
  #    key    = "projeto_final"
  #    region = "us-west-1"
  #  }
  backend "local" {
  }

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