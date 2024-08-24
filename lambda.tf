resource "aws_lambda_function" "lambda_timely_invoked_function" {
  filename         = file.zip
  function_name    = "lambda-timely-invoked-func"
  role             = aws_iam_role.lambda_timely_invoked_iam_role
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  source_code_hash = filebase64sha256("lambda.zip")
}