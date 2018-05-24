variable "service" {
  description = "Not used yet"
  default     = "cmp-service"
}

// Specific to module
variable "budget_name_prefix" {
  description = "Text to prefix budget names with"
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

variable "limit_amount" {
  description = "Budget limit amount"
  default     = "100"
}

variable "limit_unit" {
  description = "Budget units"
  default     = "USD"
}

variable "time_unit" {
  description = "Budget time period"
  default     = "MONTHLY"
}

variable "cost_filter_type" {
  description = "Not used yet"
  default     = "TagKeyValue"
}

variable "email" {
  description = "Email address to send budget alerts to"
  default     = ""
}
