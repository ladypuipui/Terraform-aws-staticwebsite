

data "archive_file" "basic_auth" {
  type        = "zip"
  source_dir  = "lambda/basic_auth"
  output_path = "lambda/dst/basic_auth.zip"
}

resource "aws_lambda_function" "basic_auth" {
  provider         = "aws.virginia"
  filename         = "${data.archive_file.basic_auth.output_path}"
  function_name    = "${var.project}_${var.stage}_basic_auth"
  role             = "${aws_iam_role.lambda-edge.arn}"
  handler          = "index.handler"
  source_code_hash = "${data.archive_file.basic_auth.output_base64sha256}"
  runtime          = "nodejs12.x"

  publish          = true

  memory_size = 128
  timeout     = 3
}


data "archive_file" "rootobject" {
  type        = "zip"
  source_dir  = "lambda/rootobject"
  output_path = "lambda/dst/rootobject.zip"
}

resource "aws_lambda_function" "rootobject" {
  provider         = "aws.virginia"
  filename         = "${data.archive_file.rootobject.output_path}"
  function_name    = "${var.project}_${var.stage}_rootobject"
  role             = "${aws_iam_role.lambda-edge.arn}"
  handler          = "index.handler"
  source_code_hash = "${data.archive_file.rootobject.output_base64sha256}"
  runtime          = "nodejs12.x"

  publish          = true

  memory_size = 128
  timeout     = 3
}