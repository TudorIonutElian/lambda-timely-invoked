/*
  aws_iam_policy_document is a data source that generates an IAM policy document that can be referenced by other resources.
  This policy document will allow the Lambda function to assume the role and execute the function.
  - statement: The policy statement that allows the Lambda function to assume the role.
    - actions: The actions that the Lambda function is allowed to perform.
    - effect: The effect of the policy statement (Allow in this case).
    - principals: The entities that are allowed to assume the role.
      - type: The type of entity (Service in this case).
      - identifiers: The identifiers of the entity (lambda.amazonaws.com in this case).
*/

data "aws_iam_policy_document" "LambdaAWSLambdaTrustPolicy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

/*
  aws_iam_role is a resource that creates an IAM role that can be assumed by the Lambda function.
  The role will be used to grant permissions to the Lambda function.
  The assume_role_policy attribute references the IAM policy document created by the aws_iam_policy_document data source.
  - name: The name of the IAM role.
  - assume_role_policy: The ARN of the IAM policy document that allows the Lambda function to assume the role.
*/
resource "aws_iam_role" "lambda_timely_invoked_iam_role" {
  name               = "lambda-timely-invoked-role"
  assume_role_policy = data.aws_iam_policy_document.LambdaAWSLambdaTrustPolicy.json
}

/*
  aws_iam_role_policy_attachment is a resource that attaches an IAM policy to an IAM role.
  In this case, the AWSLambdaBasicExecutionRole policy is attached to the IAM role created earlier.
  This policy provides the necessary permissions for the Lambda function to execute.
  - role: The name of the IAM role to attach the policy to.
  - policy_arn: The ARN of the IAM policy to attach to the role.
*/
resource "aws_iam_role_policy_attachment" "terraform_lambda_policy" {
  role       = aws_iam_role.lambda_timely_invoked_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}