resource "aws_cloudwatch_event_rule" "lambda_timely_invoked_schedule" {
  name                = "lambda-timely-invoked-schedule"
  description         = "Schedule to trigger the lambda function"
  schedule_expression = "rate(5 minutes)"

  event_pattern = <<PATTERN
    {
        "source": [
            "aws.config"
        ],
        "detail-type": [
            "Config Rules Compliance Change"
        ],
        "detail": {
            "messageType": [
                "ComplianceChangeNotification"
            ]
        }
    }
    PATTERN
}

resource "aws_cloudwatch_event_target" "lambda_timely_invoked_target" {
  rule = aws_cloudwatch_event_rule.lambda_timely_invoked_schedule.name
  arn  = aws_lambda_function.lambda_timely_invoked_function.arn

  input = <<EOF
    {
        "MESSAGE": "Hello from CloudWatch Events!"
    }
    EOF
}