# terraform-aws-db-subnet-group

Terraform module for an RDS DB subnet group — the set of subnets a
database instance or cluster may place its network interfaces in.

## Cost

DB subnet groups carry no charge. This module has no cost impact of its
own.

## Design

Split from
[`terraform-aws-db-instance`](https://github.com/kn47ytv9mv/terraform-aws-db-instance)
and
[`terraform-aws-rds-cluster`](https://github.com/kn47ytv9mv/terraform-aws-rds-cluster)
because one subnet group is routinely shared by every database in a
VPC — a 1:many relationship, and an outside consumer references the
group by name, so it is not a bundling candidate.

Span at least two availability zones. RDS requires it, and a
single-AZ group cannot host a Multi-AZ instance or an Aurora cluster —
a constraint that surfaces only when the database itself is created,
not when the group is.

## Usage

```hcl
module "subnet_group" {
  source = "kn47ytv9mv/db-subnet-group/aws"

  subnet_ids = module.vpc.subnet_ids["database"]
}
```

Or directly from this repository:

```hcl
module "subnet_group" {
  source = "github.com/kn47ytv9mv/terraform-aws-db-subnet-group"

  name       = "production-database"
  subnet_ids = ["subnet-1111", "subnet-2222"]
}
```

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.0 |
| aws | ~> 6.61 |
| random | ~> 3.9 |

## Providers

| Name | Version |
|---|---|
| aws | ~> 6.61 |
| random | ~> 3.9 |

## Inputs

| Name | Description | Default | Required |
|---|---|---|---|
| name | Name of the subnet group. If null, a unique name is generated. | `null` | no |
| description | Description of the subnet group. If null, AWS's own default applies. | `null` | no |
| subnet_ids | IDs of the subnets this group spans, from `terraform-aws-vpc-subnet` or `terraform-aws-vpc`'s `subnet_ids` output. Span at least two availability zones — RDS requires it, and a single-AZ group cannot host a Multi-AZ instance or an Aurora cluster. | `null` | no |
| tags | A map of tags to assign to the subnet group. | `null` | no |

## Outputs

| Name | Description |
|---|---|
| id | The ID (name) of the subnet group. |
| arn | The ARN of the subnet group. |
| name | The name of the subnet group. Feed this into `terraform-aws-db-instance`'s or `terraform-aws-rds-cluster`'s `db_subnet_group_name`. |

## License

MIT — see [LICENSE.md](LICENSE.md).
