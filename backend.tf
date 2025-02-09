# Customize with your own S3 bucket and DynamoDB table if you want to use a Remote Backend for States
terraform {
  backend "s3" {
    bucket         = "deletetest25"     
    key            = "poc1/terraform.tfstate" 
    region         = "us-east-1" 
    encrypt        = true
  }
}