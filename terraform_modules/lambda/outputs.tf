output "list_products_name" {
  value = aws_lambda_function.list_products.function_name
}

output "list_products_arn" {
  value = aws_lambda_function.list_products.invoke_arn
}

output "add_to_cart_name" {
  value = aws_lambda_function.add_to_cart.function_name
}

output "add_to_cart_arn" {
  value = aws_lambda_function.add_to_cart.invoke_arn
}

output "get_cart_name" {
  value = aws_lambda_function.get_cart.function_name
}
output "get_cart_arn" {
  value = aws_lambda_function.get_cart.invoke_arn
}

output "remove_from_cart_name" {
  value = aws_lambda_function.remove_from_cart.function_name
}
output "remove_from_cart_arn" {
  value = aws_lambda_function.remove_from_cart.invoke_arn
}