/*
  aws_cloudwatch_event_rule is a resource that creates a CloudWatch Event Rule.
  The rule defines the schedule for triggering the Lambda function.
  - name: The name of the CloudWatch Event Rule.
  - description: A description of the CloudWatch Event Rule.
  - schedule_expression: The schedule expression that defines when the rule should trigger the Lambda function (every 5 minutes in this case).
*/
resource "aws_cloudwatch_event_rule" "lambda_timely_invoked_schedule" {
  name                = "lambda-timely-invoked-schedule"
  description         = "Schedule to trigger the lambda function"
  schedule_expression = "rate(5 minutes)"
}


/*
  aws_cloudwatch_event_target is a resource that creates a target for the CloudWatch Event Rule.
  The target specifies the Lambda function to be invoked by the rule.
  - rule: The name of the CloudWatch Event Rule that triggers the Lambda function.
  - arn: The ARN of the Lambda function to be invoked.
  - input: The input data to be passed to the Lambda function when it is invoked.
*/
resource "aws_cloudwatch_event_target" "lambda_timely_invoked_target" {
  rule = aws_cloudwatch_event_rule.lambda_timely_invoked_schedule.name
  arn  = aws_lambda_function.lambda_timely_invoked_function.arn

  input = <<EOF
    {
        "MESSAGE": "Hello from CloudWatch Events!"
    }
    EOF
}

/*
  aws_lambda_permission is a resource that grants permission to the Lambda function to be invoked by the CloudWatch Event Rule.
  - statement_id: A unique identifier for the permission statement.
  - action: The action that the Lambda function is allowed to perform (lambda:InvokeFunction in this case).
  - function_name: The name of the Lambda function.
  - principal: The entity that is allowed to invoke the Lambda function (events.amazonaws.com in this case).
  - source_arn: The ARN of the CloudWatch Event Rule that triggers the Lambda function.
*/
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_timely_invoked_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_timely_invoked_schedule.arn
}
