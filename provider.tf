terraform {
  required_version = ">= 1.0" #Version minima de terraform
  required_providers {
    aws = {
        source = "hashicorp/aws" #De donde descargar el provider
        version = "~> 5.0" #Version 5.x
    }
  }
}

#Configuracion del provider de AWS
provider "aws" {
  region = var.aws_region #Region donde se crearan los recursos

  default_tags { #Tags por defecto que se aplicaran a todos los recursos
    tags = {
      Project = "VPC-Peering-Lab"
      ManagedBy = "Terraform"
      Environment = "Learning"
    }
  }
}