resource "aws_lambda_function" "lambda_timely_invoked_function" {
  filename         = "lambda_function_payload.zip"
  function_name    = "lambda-timely-invoked-func"
  role             = aws_iam_role.lambda_timely_invoked_iam_role
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  source_code_hash = data.archive_file.lambda_timely_invoked_function_archive.output_base64sha256
}