variable "project_name" {
  description = "Nome do projeto, usado para nomear os recursos."
  type        = string
  default     = "baitersburger-products"
}

variable "alb_arn" {
  description = "O ARN do ALB"
  type        = string
  sensitive   = true
}

variable "alb_dns_name" {
  description = "Nome do ALB"
  type        = string
}