resource "aws_cloudwatch_event_rule" "lambda_timely_invoked_schedule" {
  name                = "lambda-timely-invoked-schedule"
  description         = "Schedule to trigger the lambda function"
  schedule_expression = "rate(5 minuts)"
}

resource "aws_cloudwatch_event_target" "lambda_timely_invoked_target" {
  rule      = aws_cloudwatch_event_rule.lambda_timely_invoked_schedule.name
  arn       = aws_lambda_function.lambda_timely_invoked_function.arn
}