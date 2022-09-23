resource "oci_identity_policy" "vm_policy_read_logging" {
  provider = oci.account
  compartment_id = var.tenancy_ocid
  description    = "Policy to allow vms to read from logging"
  name           = "vm_read_loggers"
  statements = [
    # Allow service-connector to write in a bucket in its own compartment in its own tenancy
    "allow dynamic-group ${var.vm_dynamic_group_name} to use log-content in compartment ${var.compartment_name}",
  ]
}
