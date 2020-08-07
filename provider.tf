provider "aws" {
  region     = "ap-southeast-2"
  access_key = "access-key"
  secret_key = "secret-key"
}
provider "aws" {
  alias      = "useast1"
  region     = "us-east-1"
  access_key = "access-key"
  secret_key = "secret-key"
}
