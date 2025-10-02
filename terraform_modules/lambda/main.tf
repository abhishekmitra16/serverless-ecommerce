
# Lambda layer for common dependencies
resource "null_resource" "install_dependencies" {
  
  triggers = {
    requirements_hash = filesha256("${path.module}/../../requirements.txt")
  }
  
  provisioner "local-exec" {
    command = <<EOT
      mkdir -p ${path.module}/python
      pip install -r ${path.module}/../../requirements.txt -t ${path.module}/python
      cd ${path.module}
      zip -r lambda_layer.zip python
    EOT
  }
}


resource "aws_lambda_layer_version" "dependencies_layer" {
  filename          = "${path.module}/lambda_layer.zip"
  layer_name        = "ecommerce_dependencies_layer"
  compatible_runtimes = ["python3.12"]

  depends_on = [null_resource.install_dependencies]

}


# Lambda Functions
data "archive_file" "list_products_zip" {
  type        = "zip"
  source_file = "${path.module}/../../lambda_functions/list_products.py"
  output_path = "${path.module}/list_products.zip"
}

data "archive_file" "add_to_cart_zip" {
  type        = "zip"
  source_file = "${path.module}/../../lambda_functions/add_to_cart.py"
  output_path = "${path.module}/add_to_cart.zip"
}

data "archive_file" "get_cart_zip" {
  type        = "zip"
  source_file = "${path.module}/../../lambda_functions/get_cart.py"
  output_path = "${path.module}/get_cart.zip"
}

data "archive_file" "remove_from_cart_zip" {
  type        = "zip"
  source_file = "${path.module}/../../lambda_functions/remove_from_cart.py"
  output_path = "${path.module}/remove_from_cart.zip"
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "ecommerce-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    effect    = "Allow"
    actions   = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws/lambda/*:*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:Scan", "dynamodb:GetItem"]
    resources = [var.products_table_arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:GetItem", "dynamodb:UpdateItem"]
    resources = [var.cart_table_arn]
  }
}

resource "aws_iam_role_policy" "lambda_policy_attach" {
  name   = "ecommerce-lambda-policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_lambda_function" "list_products" {
  filename      = data.archive_file.list_products_zip.output_path
  function_name = "list_products"
  role          = aws_iam_role.lambda_role.arn
  handler       = "list_products.lambda_handler"
  runtime       = "python3.12"
  source_code_hash = data.archive_file.list_products_zip.output_base64sha256
  layers = [aws_lambda_layer_version.dependencies_layer.arn]

  environment {
    variables = {
        USER_POOL_ID = var.user_pool_id
        REGION       = var.region
    }
  }
}

resource "aws_lambda_function" "add_to_cart" {
  filename      = data.archive_file.add_to_cart_zip.output_path
  function_name = "add_to_cart"
  role          = aws_iam_role.lambda_role.arn
  handler       = "add_to_cart.lambda_handler"
  runtime       = "python3.12"
  source_code_hash = data.archive_file.add_to_cart_zip.output_base64sha256

layers = [aws_lambda_layer_version.dependencies_layer.arn]

  environment {
    variables = {
        USER_POOL_ID = var.user_pool_id
        REGION       = var.region
    }
  }
}

resource "aws_lambda_function" "get_cart" {
  filename      = data.archive_file.get_cart_zip.output_path
  function_name = "get_cart"
  role          = aws_iam_role.lambda_role.arn
  handler       = "get_cart.lambda_handler"
  runtime       = "python3.12"
  source_code_hash = data.archive_file.get_cart_zip.output_base64sha256

layers = [aws_lambda_layer_version.dependencies_layer.arn]

  environment {
    variables = {
        USER_POOL_ID = var.user_pool_id
        REGION       = var.region
    }
  }
}

resource "aws_lambda_function" "remove_from_cart" {
  filename      = data.archive_file.remove_from_cart_zip.output_path
  function_name = "remove_from_cart"
  role          = aws_iam_role.lambda_role.arn
  handler       = "remove_from_cart.lambda_handler"
  runtime       = "python3.12"
  source_code_hash = data.archive_file.remove_from_cart_zip.output_base64sha256
  
    layers = [aws_lambda_layer_version.dependencies_layer.arn]

  environment {
    variables = {
        USER_POOL_ID = var.user_pool_id
        REGION       = var.region
    }
  }
}