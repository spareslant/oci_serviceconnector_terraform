terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      configuration_aliases = [oci.account]
    }
  }
}
