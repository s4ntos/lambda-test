data "aws_iam_policy_document" "lambda" {
  statement {
    sid = "generic"
    principals {
      type        = "Service"
      identifiers =[
        "lambda.amazonaws.com"
      ]
    }
    actions = [
      "sts:AssumeRole",
    ]
  }
 
}

data "aws_iam_policy_document" "lambda_logs" {
  statement {
    sid = "logGroups"
    effect = "Allow"
    actions = [
        "logs:CreateLogGroup",
        ]
    resources = [
      "arn:aws:logs:eu-central-1:975183260419:log-group:/aws/lambda/${aws_lambda_function.test_lambda.function_name}",
    ]
  }
  statement {
    sid = "logStreams"
    effect = "Allow"
    actions = [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
        ]
    resources = [
      "arn:aws:logs:eu-central-1:975183260419:log-group:/aws/lambda/${aws_lambda_function.test_lambda.function_name}",
      "arn:aws:logs:*:*:log-group:/aws/lambda/${aws_lambda_function.test_lambda.function_name}:log-stream:*"
    ]
  }
 
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging for the lambda infra-eventbridge"

  policy = data.aws_iam_policy_document.lambda_logs.json
}

resource "aws_iam_role" "lambda" {
  name = "iam_for_lambda"

  assume_role_policy = data.aws_iam_policy_document.lambda.json
}


resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}