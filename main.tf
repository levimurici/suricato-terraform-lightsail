provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Enviroment = "Production"
      Name       = "Provider Tag"
    }
  }
}

module "instances" {
  source               = "./modules/application"
  /* aws_zone             = var.aws_zone */
  key_pair_name         = var.key_pair_name
  aws_connection_type  = var.aws_connection_type
  aws_key_path_private = var.aws_key_path_private
  aws_key_path_public  = var.aws_key_path_public
  aws_instance_user    = var.aws_instance_user
  bundle_id            = var.bundle_id
  blueprint_id         = var.blueprint_id
}
