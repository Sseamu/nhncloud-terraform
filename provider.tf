terraform {
required_version = ">= 1.0.0"
  required_providers {
    nhncloud = {
      source = "terraform.local/local/nhncloud"
      version = "1.0.1"
    }
  }
}

provider "nhncloud" {
  user_name   = "infrontsom@hgit.info"
  tenant_id   = "f3f0b24c10df4bd7886965fa0d518de3"
  password    = "1q2w3e4r!!"
  auth_url    = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
  region      = "KR1"
}
