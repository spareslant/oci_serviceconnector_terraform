resource "oci_identity_policy" "sc_policy" {
  compartment_id = var.parent_comp_id
  description    = var.policy_description
  name           = var.policy_name
  statements = [
    "allow any-user to read metrics in tenancy where all {request.principal.type = 'serviceconnector', request.principal.compartment.id = ${var.compartment_id}, target.compartment.id in (${var.compartment_id})}",
    "allow any-user to manage objects in compartment id ${var.compartment_id} where all {request.principal.type='serviceconnector', target.bucket.name=${var.sc_target_bucket}, request.principal.compartment.id=${var.compartment_id}}"
  ]
}
