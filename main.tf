data "aws_caller_identity" "current" {}

# Activate tags for cost allocation tracking
# Must be done by master account

# https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_budgets_CostTypes.html
#
/*
# This is future work for single budget that can set most things
locals {
  cost_filters = {
    AZ = {
      AZ = ""
    }
    LinkedAccount = {
      LinkedAccount = "${join(",", var.account_ids)}"
    }
    Operation = {
      Operation = ""
    }
    PurchaseType = {
      PurchaseType = ""
    }
    Service = {
      Service = ""
    }
    TagKeyValue = {
      TagKeyValue = "Stack$$${var.service}"
    }
    UsageType = {
      UsageType = ""
    }
  }
}
/**/
resource "aws_budgets_budget" "budgets" {
  count       = "${length(var.budgets)}"
  account_id  = "${data.aws_caller_identity.current.account_id}"
  name        = "${var.budget_name_prefix}${lookup(var.budgets[count.index], "name")}-${title(lower(var.time_unit))}"
  budget_type = "${var.budget_type}"
  limit_unit  = "${var.limit_unit}"
  time_unit   = "${var.time_unit}"

  limit_amount = "${var.time_unit == "ANNUALLY" ?
    lookup(var.budgets[count.index], "limit", "100") * 12 :
    var.time_unit == "QUARTERLY" ?
      lookup(var.budgets[count.index], "limit", "100") * 3 :
      lookup(var.budgets[count.index], "limit", "100")
  }"

  time_period_start = "${var.time_unit == "ANNUALLY" ?
    "${substr(timestamp(), 0, 5)}01-01_00:00" :
    var.time_unit == "QUARTERLY" ?
      "${substr(timestamp(), 0, 5)}${format("%02d", (substr(timestamp(), 5, 2) - 1) / 3 * 3 + 1)}-01_00:00" :
      "${substr(timestamp(), 0, 8)}01_00:00"
  }"

  cost_filters = {
    LinkedAccount = "${lookup(var.budgets[count.index], "account")}"
  }

  lifecycle {
    ignore_changes = ["time_period_start"]
  }
}

# Attributes: id

