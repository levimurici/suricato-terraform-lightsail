variable "aws_zone" {
  description = "The zone to operate under, if not specified by a given resource."
  default = "us-east-1a"
}

variable "key_pair_name" {
  description = "Key name de acesso"
  default     = "terraform-aws"
}

variable "aws_connection_type" {
  description = "Connection type."
  default     = "ssh"
}

variable "aws_key_path_private" {
  description = "Private Key path."
  default     = "~/.ssh/terraform-aws"
}

variable "aws_key_path_public" {
  description = "Private Key path."
  default     = "~/.ssh/terraform-aws.pub"
}

variable "aws_instance_user" {
  description = "Instance user for remote connection."
  default     = "ubuntu"
}

variable "bundle_id" {
  description = "Bundle id."
  default     = "nano_2_0"
}

# Default: Ubuntu 20.04
variable "blueprint_id" {
  description = "Operating System."
  default     = "ubuntu_20_04"
}