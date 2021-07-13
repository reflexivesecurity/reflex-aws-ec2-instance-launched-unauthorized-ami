module "sqs_lambda" {
  source                    = "git::https://github.com/reflexivesecurity/reflex-engine.git//modules/sqs_lambda?ref=v1.0.0"
  cloudwatch_event_rule_id  = var.cloudwatch_event_rule_id
  cloudwatch_event_rule_arn = var.cloudwatch_event_rule_arn
  function_name             = "InstanceLaunchedUnauthorizedAmi"
  source_code_dir           = "${path.module}/../../source"
  handler                   = "reflex_aws_ec2_instance_launched_unauthorized_ami.lambda_handler"
  lambda_runtime            = "python3.7"
  environment_variable_map = {
    SNS_TOPIC     = var.sns_topic_arn,
    GOLDEN_AMI_ID = var.golden_ami_id
  }

  queue_name    = "InstanceLaunchedUnauthorizedAmi"
  delay_seconds = 0

  target_id = "InstanceLaunchedUnauthorizedAmi"

  sns_topic_arn  = var.sns_topic_arn
  sqs_kms_key_id = var.reflex_kms_key_id
}
