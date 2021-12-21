

data "archive_file" "infra_eventbridge" {
  type             = "zip"
  source_file      = "${path.module}/src/main.py"
  output_file_mode = "0666"
  output_path      = "${path.module}/tmp/infra-eventbridge.zip"
}

resource "aws_lambda_function" "test_lambda" {
  filename      = data.archive_file.infra_eventbridge.output_path
  function_name = "infra_eventbridge_payload"
  role          = aws_iam_role.lambda.arn
  handler       = "lambda.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("${path.module}/tmp/infra-eventbridge.zip")

  runtime = "python3.6"
}