terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.94.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.4.0"
    }
		local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
  }
  required_version = "~> 1.2.5"
}
