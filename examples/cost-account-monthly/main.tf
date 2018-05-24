module "budgets" {
  source  = "../../"
  budgets = "${var.budgets}"
  email   = "user@company.com"
}
