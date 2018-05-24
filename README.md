# terraform-aws-budget

Terraform module to setup AWS budgets and notifications

This is fairly specific for now. It can create budgets for multiple linked accounts. Each with it's own limit.
Notification is only supported for a single email address

NOTE: Setting up notification and subscribers is not currently supported in Terraform

Notifications are predefined in this module. They are:
- 110% of forecasted
- 80% of actual
- 90% of actual
