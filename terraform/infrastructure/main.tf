terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
  access_key = "AKIAWKKSGOCX2MKMLA5I"
  secret_key = "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"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
