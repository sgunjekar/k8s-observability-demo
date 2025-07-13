
module "vpc" {
  source = "./vpc"
}

module "eks" {
  source          = "./eks"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.subnet_ids
}

module "vault" {
  source = "./vault"
}
provider "vault" {
  address = "http://127.0.0.1:8200"  # use actual accessible address
  token   = var.vault_token         # or use env VAULT_TOKEN
}

variable "vault_token" {
  type      = string
  sensitive = true
}


