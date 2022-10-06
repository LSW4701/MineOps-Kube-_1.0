output "vpc" {
  value = module.vpc
}

output "subnet_groups" {
  value = module.subnet_group
}

output "vpc1" {
  value = module.vpc.arn
}