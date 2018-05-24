variable "region" {
  default = "us-west-2"
}

variable "budgets" {
  description = "List of account budget maps. Each map contains: name (name of budget), account (AWS linked account ID), and limit (budget limit)"

  default = [
    {
      name    = "acc-1"
      account = "123456789011"
      limit   = 100
    },
    {
      name    = "acc-2"
      account = "123456789012"
      limit   = 200
    },
    {
      name    = "acc-3"
      account = "123456789013"
      limit   = 300
    },
  ]
}
