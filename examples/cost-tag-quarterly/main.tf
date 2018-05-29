module "budget-1" {
  source             = "../../"
  emails             = ["user@company.com", "user2@company.com"]
  budget_name        = "service-1"
  budget_name_prefix = "Testing-"
  tag_value          = "service-1"
  time_unit          = "QUARTERLY"
}
