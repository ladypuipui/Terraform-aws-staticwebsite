resource "aws_iam_role" "lambda-edge" {
  name = "${var.site_domain}-lambda-edge"

  assume_role_policy = "${data.aws_iam_policy_document.lambda-assume-role.json}"
}

data "aws_iam_policy_document" "lambda-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "basic" {
  role       = "${aws_iam_role.lambda-edge.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}