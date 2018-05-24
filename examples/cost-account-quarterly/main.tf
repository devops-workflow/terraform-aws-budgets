
module "budgets" {
  source    = "../../"
  budgets   = "${var.budgets}"
  email     = "snemetz@wiser.com"
  time_unit = "QUARTERLY"
}
