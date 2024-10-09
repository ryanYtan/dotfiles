#!/bin/bash
#
echo "+==============================+"
echo "+     Installing AWS CLI v2    +"
echo "+==============================+"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm awscliv2.zip

