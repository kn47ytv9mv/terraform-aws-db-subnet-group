variable "name" {
  default     = null
  description = "Name of the subnet group. If null, a unique name is generated."
}

variable "description" {
  default     = null
  description = "Description of the subnet group. If null, AWS's own default applies."
}

variable "subnet_ids" {
  default     = null
  description = "IDs of the subnets this group spans, from terraform-aws-vpc-subnet or terraform-aws-vpc's subnet_ids output. Span at least two availability zones — RDS requires it, and a single-AZ group cannot host a Multi-AZ instance or an Aurora cluster."
}

variable "tags" {
  default     = null
  description = "A map of tags to assign to the subnet group."
}
