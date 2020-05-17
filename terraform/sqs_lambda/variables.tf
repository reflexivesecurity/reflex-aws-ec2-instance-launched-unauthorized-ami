variable "sns_topic_arn" {
  description = "SNS topic arn of central or local sns topic"
  type        = string
}

variable "reflex_kms_key_id" {
  description = "KMS Key Id for common reflex usage."
  type        = string
}

variable "golden_ami_id" {
  description = "AMI ID that will be designated as the golden ami"
  default     = "ami-REPLACE_WITH_GOLDEN_AMI_ID"
  type        = string
}
variable "cloudwatch_event_rule_id" {
  description = "Easy name of CWE"
  type        = string
}

variable "cloudwatch_event_rule_arn" {
  description = "Full arn of CWE"
  type        = string
}
