resource "aws_cloudformation_stack" "VPC" {
  parameters = {
    VPCName = var.vpc_name
    CIDR    = var.vpc_cidr
  }

  name         = var.stack_name
  template_url = var.template_url
}