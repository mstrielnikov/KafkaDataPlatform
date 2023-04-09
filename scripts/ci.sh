#!/usr/bin/sh

# Linting
terraform fmt -recursive -diff -check 

# Validation 
terraform init -backend=false

terraform validate -json

# Lint
TFLINT_LOG=debug tflint

tflint --color --recursive --module --minimum-failure-severity=warning # --minimum-failure-severity=error

# Static analysis
terraform init 

terraform plan -out tf.plan 

terraform show -json tf.plan  > tf.json  

checkov -f tf.json

# Cost analysis
infracost register

infracost diff --path .

infracost breakdown --path . --format html > report.html        

exit 0;