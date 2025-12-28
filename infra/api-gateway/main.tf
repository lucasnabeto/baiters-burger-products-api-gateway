resource "aws_api_gateway_rest_api" "api" {
  name        = "${var.project_name}-api"
  description = "API para o sistema Baiters Burger Products"

  body = templatefile("${path.module}/openapi-bundled.yaml", {
    # vpc_link_id           = aws_apigatewayv2_vpc_link.ecs_alb_vpclink_v2.id
    alb_dns_name          = var.alb_dns_name
    lambda_authorizer_arn = data.aws_lambda_function.existing_lambda_authorizer.arn
  })

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(aws_api_gateway_rest_api.api.body)
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "production"
}

resource "aws_lambda_permission" "api_gateway_authorizer_invoke" {
  statement_id  = "AllowAPIGatewayToInvokeAuthorizer"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.existing_lambda_authorizer.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/authorizers/*"
}

# resource "aws_api_gateway_vpc_link" "ecs_alb_link" {
#   name        = "${var.project_name}-vpc-link"
#   description = "VPC Link para o ALB do cluster EKS"

#   target_arns = [var.alb_arn]

#   tags = {
#     Project = var.project_name
#   }
# }

# resource "aws_apigatewayv2_vpc_link" "ecs_alb_vpclink_v2" {
#   name        = "${var.project_name}-vpc-link"
#   security_group_ids = [data.aws_security_group.alb_sg.id]
#   subnet_ids         = data.aws_subnets.all_default_subnets.ids

#    tags = {
#     Project = var.project_name
#   }
# }