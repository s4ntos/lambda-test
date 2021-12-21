locals {
  env       = terraform.workspace == "Default" ? "PRD" : upper(element(split("-", terraform.workspace), 0))
  namespace = lower(local.env)
  location  = element(split("-", terraform.workspace), 1) == local.namespace ? "" : format("-%s", element(split("-", terraform.workspace), 1))
  zone = element(split("-",local.location),1)

    common_tags = {
    "Service"           = "INFRA"
    "Environment"       = "PROD"
    "IOTEnvironment"    = local.env
    "LMEntity"          = "VGSL"
    "BU"                = "GROUP-ENTERPRISE"
    "Project"           = "INFRA"
    "ManagedBy"         = "iotinfrastructure@vodafone.com"
    "SecurityZone"      = "A"
    "Confidentiality"   = "C3"
    "TaggingVersion"    = "V2.4"
    "BusinessService"   = "VGSL-AWS-INFRA"
    "PCI"               = "No"
    "SOX"               = "No"
    "Criticality"       = "Yes"
    "terraform"         = "Yes"
    "terraform-project" = "infra-eventbridge"
  }
}

