variable "workspace_iam_roles" {
  default = {
    dev     = "build"
  }
}

provider "aws" {
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
  profile                 = var.workspace_iam_roles[local.namespace]
  default_tags {
    tags = local.common_tags
  }
}
