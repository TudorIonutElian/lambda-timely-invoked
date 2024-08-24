data "aws_iam_policy_document" "LambdaAWSLambdaTrustPolicy" {
  statement {
    actions    = ["sts:AssumeRole"]
    effect     = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_timely_invoked_iam_role" {
  name               = "lambda-timely-invoked-role"
  assume_role_policy = "${data.aws_iam_policy_document.LambdaAWSLambdaTrustPolicy.json}"
}

resource "aws_iam_role_policy_attachment" "terraform_lambda_policy" {
  role       = "${aws_iam_role.lambda_timely_invoked_iam_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}