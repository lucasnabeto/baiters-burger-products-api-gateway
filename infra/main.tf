module "aws_api_gateway" {
  source = "./api-gateway"

  alb_arn      = data.aws_lb.lb_arn.arn
  alb_dns_name = data.aws_lb.lb_arn.dns_name
}