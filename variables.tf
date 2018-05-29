// Specific to module
variable "budget_name_prefix" {
  description = "Text to prefix budget names with"
  default     = ""
}

variable "budget_name" {
  description = "Budget name (when managing a single budget)"
  default     = ""
}

variable "budget_type" {
  description = "Type of budget"
  default     = "COST"
}

variable "budgets" {
  description = "List of account budget maps. Each map contains: name (name of budget), account (AWS linked account ID), and limit (budget limit)"
  type        = "list"
  default     = []
}

variable "cost_filter_type" {
  description = "Cost filter type (when managing a single budget)"
  default     = "TagKeyValue"
}

variable "limit_amount" {
  description = "Budget limit amount"
  default     = "100"
}

variable "limit_unit" {
  description = "Budget units"
  default     = "USD"
}

variable "tag_key" {
  description = "Tag key for cost filter by tag (TagKeyValue)"
  default     = "Stack"
}

variable "tag_value" {
  description = "Tag value for cost filter by tag (TagKeyValue)"
  default     = ""
}

variable "time_unit" {
  description = "Budget time period"
  default     = "MONTHLY"
}

variable "email" {
  description = "Email address to send budget alerts to. Used by account budgets."
  default     = ""
}

variable "emails" {
  description = "List of email addresses to send budget alerts to. Maximum of 10. Used by single budgets"
  default     = []
}
