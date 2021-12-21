# This is to optionally manage the CloudWatch Log Group for the Lambda Function.
# If skipping this resource configuration, also add "logs:CreateLogGroup" to the IAM policy below.
resource "aws_cloudwatch_log_group" "infra_eventbridge" {
  name              = "/aws/lambda/infra_eventbridge"
  retention_in_days = 14
}
