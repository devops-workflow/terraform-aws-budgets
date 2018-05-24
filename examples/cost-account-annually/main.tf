module "budgets" {
  source    = "../../"
  budgets   = "${var.budgets}"
  email     = "user@company.com"
  time_unit = "ANNUALLY"
}
