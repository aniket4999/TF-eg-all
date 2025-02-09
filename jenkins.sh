#!/bin/bash

# Variables
ROLE_ARN="Jenkins123" 
REGION="us-east-1"
AWS_ACCOUNTS=("905418080828" "905418080828") # Add more accounts as needed

# Function to assume role and set AWS credentials
assume_role() {
  local account_id=$1
  CREDENTIALS=$(aws sts assume-role --role-arn "arn:aws:iam::$account_id:role/$ROLE_ARN" --role-session-name "GetEC2DetailsSession" --query "Credentials" --output json)

  export AWS_ACCESS_KEY_ID=$(echo $CREDENTIALS | jq -r '.AccessKeyId')
  export AWS_SECRET_ACCESS_KEY=$(echo $CREDENTIALS | jq -r '.SecretAccessKey')
  export AWS_SESSION_TOKEN=$(echo $CREDENTIALS | jq -r '.SessionToken')
}

# Loop through AWS accounts to get EC2 details
for account_id in "${AWS_ACCOUNTS[@]}"; do
  echo "Assuming role for account: $account_id"
  assume_role $account_id

  echo "Fetching EC2 instances in region: $REGION for account: $account_id"
  aws ec2 describe-instances --region $REGION --query "Reservations[*].Instances[*].{ID:InstanceId,Type:InstanceType,State:State.Name,Launch:LaunchTime}" --output table
done
