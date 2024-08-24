/**
 * This file is used to create a lambda function and attach the role to it.
 * The lambda function is created using the zip file of the lambda function code.
 * The role is created and attached to the lambda function.
 * The role has a policy attached to it which allows the lambda function to access the S3 bucket.
 */
data "archive_file" "lambda_timely_invoked_archive" {
  type        = "zip"
  source_dir  = "/lambda"
  output_path = "${lambda}.zip"
}