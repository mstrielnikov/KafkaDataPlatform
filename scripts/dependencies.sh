#!/usr/bin/sh

# Install Terraform infrastructure cost analyzsis tool
curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | bash

# Install Terraform linting tool
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# Install Terraform static analysis tool
pip3 install checkov

# Install ansible linter
pip3 install ansible-lint

exit 0;