resource "random_uuid" "resource" {}

resource "aws_db_subnet_group" "resource" {
  name        = coalesce(var.name, random_uuid.resource.id)
  description = var.description
  subnet_ids  = var.subnet_ids

  tags = var.tags
}

output "id" {
  description = "The ID (name) of the subnet group."
  value       = aws_db_subnet_group.resource.id
}

output "arn" {
  description = "The ARN of the subnet group."
  value       = aws_db_subnet_group.resource.arn
}

output "name" {
  description = "The name of the subnet group. Feed this into terraform-aws-db-instance's or terraform-aws-rds-cluster's db_subnet_group_name."
  value       = aws_db_subnet_group.resource.name
}
