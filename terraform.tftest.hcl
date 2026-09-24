mock_provider "aws" {}

run "name_defaults_to_random_uuid" {
  command = apply

  variables {
    subnet_ids = ["subnet-1111", "subnet-2222"]
  }

  assert {
    condition     = aws_db_subnet_group.resource.name == random_uuid.resource.id
    error_message = "Leaving name unset should fall back to the generated random_uuid."
  }
}

run "explicit_name_overrides_random_uuid" {
  command = plan

  variables {
    name       = "my-subnet-group"
    subnet_ids = ["subnet-1111", "subnet-2222"]
  }

  assert {
    condition     = aws_db_subnet_group.resource.name == "my-subnet-group"
    error_message = "An explicit name should override the random_uuid fallback."
  }
}

run "subnet_ids_pass_through" {
  command = plan

  variables {
    subnet_ids = ["subnet-1111", "subnet-2222", "subnet-3333"]
  }

  assert {
    condition     = length(aws_db_subnet_group.resource.subnet_ids) == 3
    error_message = "Every subnet ID supplied should reach the subnet group."
  }
}

run "readme_default_example" {
  command = plan

  variables {
    subnet_ids = ["subnet-1111", "subnet-2222"]
  }
}

run "readme_named_group_example" {
  command = plan

  variables {
    name       = "production-database"
    subnet_ids = ["subnet-1111", "subnet-2222"]
  }
}
