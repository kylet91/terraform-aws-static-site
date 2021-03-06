# Terraform - AWS Static Hosted Website
This Terraform script creates a static hosted website from AWS S3, served by Load Balancers, and secured with an Amazon SSL Certificate.

If you use this repo as is, you can basically point your domain to the name servers provided in the output, and the Terraform script _should_ set up all A/CNAME/TXT records, install the SSL, configure the CDN, etc.

### Note
There are two AWS providers in provider.tf because SSLs can _only_ be issued from us-east-1. To change where your S3 bucket is hosted, change the first provider.
