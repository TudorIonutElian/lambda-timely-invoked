/*
  * data "archive_file" is used to create a zip file from the source file.
  * The source file is the index.js file in the lambda directory.
  * The output path is the lambda_function_payload.zip file.
   - type: The type of archive to create (zip in this case).
    - source_file: The path to the file or directory to be archived.
    - output_path: The path to save the archive file.
*/

data "archive_file" "lambda_timely_invoked_function_archive" {
  type        = "zip"
  source_file = "lambda/index.js"
  output_path = "lambda_function_payload.zip"
}