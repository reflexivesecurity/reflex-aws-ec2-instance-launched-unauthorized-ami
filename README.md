# reflex-aws-ec2-instance-launched-unauthorized-ami
A Reflex rule to detect when an instance was launched using an AMI that hasn't been authorized.

To learn more about Golden AMIs and managing authorized AMIs, see [the AWS Blog](https://aws.amazon.com/blogs/awsmarketplace/announcing-the-golden-ami-pipeline/).

## Getting Started
To get started using Reflex, check out [the Reflex Documentation](https://docs.cloudmitigator.com/).

## Usage
To use this rule either add it to your `reflex.yaml` configuration file:  
```
rules:
  aws:
    - ec2-instance-launched-unauthorized-ami:
        configuration:
            golden_ami_id: ami-1234567890abcdefg
        version: latest
```

or add it directly to your Terraform:  
```
module "ec2-instance-launched-unauthorized-ami" {
  source           = "github.com/reflexivesecurity/reflex-aws-ec2-instance-launched-unauthorized-ami?ref=latest"
  sns_topic_arn     = module.central-sns-topic.arn
  reflex_kms_key_id = module.reflex-kms-key.key_id
  golden_ami_id     = "ami-1234567890abcdefg"
}
```

Note: The `sns_topic_arn` and `reflex_kms_key_id` example values shown here assume you generated resources with `reflex build`. If you are using the Terraform on its own you need to provide your own valid values.

## Configuration
This rule has the following configuration options:

<dl>
  <dt>golden_ami_id</dt>
  <dd>
  <p>Sets the authorized AMI ID.</p>

  <em>Required</em>: Yes  

  <em>Type</em>: string
  </dd>
</dl>

## Contributing
If you are interested in contributing, please review [our contribution guide](https://docs.cloudmitigator.com/about/contributing.html).

## License
This Reflex rule is made available under the MPL 2.0 license. For more information view the [LICENSE](https://github.com/reflexivesecurity/reflex-aws-ec2-instance-launched-unauthorized-ami/blob/master/LICENSE) 
