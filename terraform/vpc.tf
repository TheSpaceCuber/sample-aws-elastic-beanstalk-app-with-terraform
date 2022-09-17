module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "main-vpc"
  cidr = var.vpc_cidr_block

  azs             = var.vpc_azs
  public_subnets  = var.vpc_public_cidr_blocks    // 1a, 1b
  // https://github.com/terraform-aws-modules/terraform-aws-vpc/issues/46
  private_subnets = ["10.0.128.0/20", "10.0.144.0/20"] // 1a, 1b

  # One NAT Gateway per availability zone
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
