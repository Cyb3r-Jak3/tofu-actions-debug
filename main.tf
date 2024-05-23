terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "~> 3"
    }
  }
}


resource "random_string" "example" {
  length = 16
  special = false
}