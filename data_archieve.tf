data "archive_file" "lambda_timely_invoked_function_archive" {
  type        = "zip"
  source_file = "index.js"
  output_path = "lambda_function_payload.zip"
}