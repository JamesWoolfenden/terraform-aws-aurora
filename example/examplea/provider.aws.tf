# holden:ignore:HLD_TF_013
provider "aws" {
  region = "eu-west-2"

  default_tags {
    tags = {
      managed_by = "terraform"
      module     = "terraform-aws-aurora"
    }
  }
}
