# data "aws_vpc" "vpc_default" {
#   default = true
# }

# data "aws_subnets" "all_default_subnets" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.vpc_default.id]
#   }
# }

data "aws_lambda_function" "existing_lambda_authorizer" {
  function_name = "BaitersBurgerProducts-LambdaAuthorizer"
}

data "aws_security_group" "alb_sg" {
  name = "alb-sg"
}