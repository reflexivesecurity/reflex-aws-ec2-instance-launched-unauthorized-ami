""" Module for InstanceLaunchedUnauthorizedAmi """

import json
import os

import boto3
from reflex_core import AWSRule, subscription_confirmation

GOLDEN_AMI_ID = os.environ.get("GOLDEN_AMI_ID")


class InstanceLaunchedUnauthorizedAmi(AWSRule):
    """ Rule to determine if an EC2 instance is ran with an unspecified AMI """

    def __init__(self, event):
        super().__init__(event)

    def extract_event_data(self, event):
        """ Extract required event data """
        self.instances_set = event["detail"]["responseElements"]["instancesSet"][
            "items"
        ]

    def resource_compliant(self):
        """
        Determine if the resource is compliant with your rule.

        Return True if it is compliant, and False if it is not.
        """
        compliance = True
        for item in self.instances_set:
            if item["imageId"] != GOLDEN_AMI_ID:
                compliance = False
        return compliance

    def get_remediation_message(self):
        """ Returns a message about the remediation action that occurred """
        return f"An instance was launched that did not use the designated AMI ID: {GOLDEN_AMI_ID}."


def lambda_handler(event, _):
    """ Handles the incoming event """
    print(event)
    event_payload = json.loads(event["Records"][0]["body"])
    if subscription_confirmation.is_subscription_confirmation(event_payload):
        subscription_confirmation.confirm_subscription(event_payload)
        return
    rule = InstanceLaunchedUnauthorizedAmi(event_payload)
    rule.run_compliance_rule()
