locals {
  env       = terraform.workspace == "Default" ? "PRD" : upper(element(split("-", terraform.workspace), 0))
  namespace = lower(local.env)
  location  = element(split("-", terraform.workspace), 1) == local.namespace ? "" : format("-%s", element(split("-", terraform.workspace), 1))
  zone = element(split("-",local.location),1)

    common_tags = {
    "Environment"       = "local.env"
  }
}

data "aws_caller_identity" "current" {
}


data "aws_region" "current" {
}