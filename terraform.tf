terraform {
  required_version = "> 1.0"
  # backend "s3" {
  #   bucket         = "iot-terraform-shared-state-storage-s3"
  #   dynamodb_table = "terraform-state-lock-dynamo"
  #   region         = "eu-west-1"
  #   key            = "project/infra-eventbridge"
  #   profile        = "root"
  # }
}

