resource "aws_lambda_function" "lambda_timely_invoked_function" {
  filename         = file.zip
  function_name    = "lambda-timely-invoked-func"
  role             = aws_iam_role.lambda_timely_invoked_iam_role
  handler          = "index.handler"
  runtime          = "nodejs12.x"
  source_code_hash = aws_data_archive_file.lambda_timely_invoked_archive.output_base64sha256
}