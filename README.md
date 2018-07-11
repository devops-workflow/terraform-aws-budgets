# terraform-aws-budgets

[![CircleCI](https://circleci.com/gh/devops-workflow/terraform-aws-budgets/tree/master.svg?style=svg)](https://circleci.com/gh/devops-workflow/terraform-aws-budgets/tree/master)

Terraform module to setup AWS budgets and notifications

For now it can manage 2 types of budgets:

- Account budgets for a single account or multiple linked accounts.
  Each with it's own limit.
- Budget by tag

Notification is only supported for a single email address

NOTE: Setting up notification and subscribers is not currently supported in Terraform

Notifications are predefined in this module. They are:

- 110% of forecasted
- 80% of actual
- 90% of actual
