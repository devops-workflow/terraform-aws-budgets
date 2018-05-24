
# https://boto3.readthedocs.io/en/latest/reference/services/budgets.html

'''
Get current notifications
rm any not in desired
update subscribers
create any desired that does not exist
'''

import boto3
import json
import sys

def notification_create(client, account, budget, notification, subscribers):
    result = client.create_notification(AccountId=account, BudgetName=budget, Notification=notification, Subscribers=subscribers)
    return result

def notification_data(notification_type, comparision, threshold, threshold_type):
    data = {
            'NotificationType': notification_type,
            'ComparisonOperator': comparision,
            'Threshold': threshold,
            'ThresholdType': threshold_type
        }
    return data
def notification_delete():
def notification_update():

def subscriber_create():
def subscriber_data(type, address):
    data = {
        'SubscriptionType': type,
        'Address': address
    }
    return data
def subscriber_delete():
def subscriber_update():

args = json.loads(sys.stdin.read())

budgets = boto3.client('budgets')
result = budgets.describe_notifications_for_budget(
    AccountId=args['account_id'],
    BudgetName=args['budget_name'],
    MaxResults=100
)
notifications_old = result['Notifications']
sys.stderr.write(json.dumps(notifications_old, indent=2))
# Compare all current notifications to desired. If 100% match to nothing, else delete all current and create desired
# If 100 match, compare all subscribers per notification to desired.

# Check for existing notification
notify_desired = notification_data(args['NotificationType'], args['ComparisonOperator'], args['Threshold'], args['ThresholdType'])
sys.stderr.write(json.dumps(notify_desired, indent=2))
for notification in notifications_old:
    # Need old Terraform state to find match
    if cpm(notification, notify_desired) != 0:
# For each get subscribers ?
#   describe_subscribers_for_notification()

#print(json.dumps(notifications_old, indent=2))
print(json.dumps(args, indent=2))


'''
{ "account_id": "830036458304", "budget_name": "Testing-cmp-service" }
{ "ComparisonOperator": "GREATER_THAN", "NotificationType": "ACTUAL", "Threshold": "90", "ThresholdType": "PERCENTAGE", "account_id": "830036458304", "budget_name": "Testing-cmp-service" }

'''
