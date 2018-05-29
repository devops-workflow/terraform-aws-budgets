# creating manually, since there isn't a budget notification resource yet
# https://github.com/terraform-providers/terraform-provider-aws/issues/4548

# This is a quick and dirty method for setting up notifications for now

# https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/billing-limits.html#limits-reports
# https://docs.aws.amazon.com/sns/latest/api/API_Subscribe.html#API_Subscribe_RequestParameters

locals {
  # Prefix for single budget
  notification_cmd_prefix_single = <<EOF
aws budgets create-notification \
--account-id ${data.aws_caller_identity.current.account_id} \
--budget-name ${var.budget_name_prefix}${var.budget_name}-${title(lower(var.time_unit))} \
--subscribers ${join(" ", formatlist("SubscriptionType=EMAIL,Address=%s", var.emails))} \
--notification \
EOF

  # Prefix for multiple budgets. So only contain stuff that is common to all budgets in var.budgets
  # Could move subscribers here as long as only supporting one
  notification_cmd_prefix = <<EOF
aws budgets create-notification \
--account-id ${data.aws_caller_identity.current.account_id} --budget-name \
EOF
}

//
// Notifications for single budget
//
# When forecasted bill exceeds budget by 10%
resource "null_resource" "budget_forecast_110" {
  count = "${length(var.budgets) == 0 ? 1 : 0}"

  triggers {
    budget_id = "${aws_budgets_budget.budget.id}"
    prefix    = "${local.notification_cmd_prefix_single}"
  }

  provisioner "local-exec" {
    command = <<CMD
${local.notification_cmd_prefix_single} NotificationType=FORECASTED,ComparisonOperator=GREATER_THAN,Threshold=110,ThresholdType=PERCENTAGE
CMD
  }
}

# When actual bill exceeds 90% budget
resource "null_resource" "budget_actual_90" {
  count = "${length(var.budgets) == 0 ? 1 : 0}"

  triggers {
    budget_id = "${aws_budgets_budget.budget.id}"
    prefix    = "${local.notification_cmd_prefix_single}"
  }

  provisioner "local-exec" {
    command = <<CMD
${local.notification_cmd_prefix_single} NotificationType=ACTUAL,ComparisonOperator=GREATER_THAN,Threshold=90,ThresholdType=PERCENTAGE
CMD
  }
}

# When actual bill exceeds 80% budget
resource "null_resource" "budget_actual_80" {
  count = "${length(var.budgets) == 0 ? 1 : 0}"

  triggers {
    budget_id = "${aws_budgets_budget.budget.id}"
    prefix    = "${local.notification_cmd_prefix_single}"
  }

  provisioner "local-exec" {
    command = <<CMD
${local.notification_cmd_prefix_single} NotificationType=ACTUAL,ComparisonOperator=GREATER_THAN,Threshold=80,ThresholdType=PERCENTAGE
CMD
  }
}

//
// Notifications for multiple budgets
//
# When forecasted bill exceeds budget by 10%
resource "null_resource" "budgets_forecast_110" {
  count = "${length(var.budgets)}"

  triggers {
    budget_id = "${element(aws_budgets_budget.budgets.*.id, count.index)}"
    prefix    = "${local.notification_cmd_prefix}"
  }

  provisioner "local-exec" {
    command = <<CMD
${local.notification_cmd_prefix} ${var.budget_name_prefix}${lookup(var.budgets[count.index], "name")}-${title(lower(var.time_unit))} \
--subscribers SubscriptionType=EMAIL,Address=${var.email} \
--notification NotificationType=FORECASTED,ComparisonOperator=GREATER_THAN,Threshold=110,ThresholdType=PERCENTAGE
CMD
  }
}

# When actual bill exceeds 90% budget
resource "null_resource" "budgets_actual_90" {
  count = "${length(var.budgets)}"

  triggers {
    budget_id = "${element(aws_budgets_budget.budgets.*.id, count.index)}"
    prefix    = "${local.notification_cmd_prefix}"
  }

  provisioner "local-exec" {
    command = <<CMD
${local.notification_cmd_prefix} ${var.budget_name_prefix}${lookup(var.budgets[count.index], "name")}-${title(lower(var.time_unit))} \
--subscribers SubscriptionType=EMAIL,Address=${var.email} \
--notification NotificationType=ACTUAL,ComparisonOperator=GREATER_THAN,Threshold=90,ThresholdType=PERCENTAGE
CMD
  }
}

# When actual bill exceeds 80% budget
resource "null_resource" "budgets_actual_80" {
  count = "${length(var.budgets)}"

  triggers {
    budget_id = "${element(aws_budgets_budget.budgets.*.id, count.index)}"
    prefix    = "${local.notification_cmd_prefix}"
  }

  provisioner "local-exec" {
    command = <<CMD
${local.notification_cmd_prefix} ${var.budget_name_prefix}${lookup(var.budgets[count.index], "name")}-${title(lower(var.time_unit))} \
--subscribers SubscriptionType=EMAIL,Address=${var.email} \
--notification NotificationType=ACTUAL,ComparisonOperator=GREATER_THAN,Threshold=80,ThresholdType=PERCENTAGE
CMD
  }
}

# Notify: email, sns,


/*
resource "null_resource" "notification" {
  triggers {
    # Strings only ?
    account_id    = "${data.aws_caller_identity.current.account_id}"
    budget_name   = "${local.budget_name}"
    budget_id     = "${aws_budgets_budget.this.id}"
  }
  provisioner "local-exec" {
    command = "cmd arg1 arg2"
    #working_dir =
    #interpreter =
    #environment {
    # var = val
    #}
  }
  }
}
/**/
/*
# Options to get old state:
# Data lookup in state to get old values ?
# In script read state file
data "external" "notification" {
  program = ["python", "${path.module}/scripts/notifications.py"]
  query = {
    # Can only pass strings
    account_id    = "${data.aws_caller_identity.current.account_id}"
    budget_name   = "${local.budget_name}"
    #notification  = {
    # Make each a , seperated string?
        NotificationType    = "ACTUAL"
        ComparisonOperator  = "GREATER_THAN"
        Threshold           = 90.0
        ThresholdType       = "PERCENTAGE"
    #}
    #Subscriber
    # sns = arn
    # email = addres (up to 10)
  }
}

output "external" {
  value = "${data.external.notification.result}"
}
/**/

