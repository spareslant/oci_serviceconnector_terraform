resource "oci_identity_policy" "sc_policy" {
  compartment_id = var.parent_comp_id
  description    = var.policy_description
  name           = var.policy_name
  statements = [
    "Allow group ${var.group_name} to read metrics in compartment ${var.compartment_name}"
  ]
}
