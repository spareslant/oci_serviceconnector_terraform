resource "oci_identity_policy" "sc_policy_read_source" {
  provider       = oci.account
  compartment_id = var.tenancy_ocid
  description    = "Policy to allow sch to read from ${var.logs_tenancy} and write to a bucket"
  name           = "sch_read_logs_from_${var.logs_tenancy}"
  statements = [
    # "define tenancy ${var.logs_tenancy} as ${var.logs_tenancy_id}",

    # Endorse service-connector to read log-objects from other tenancy
    # "endorse any-user to read logging-family in tenancy ${var.logs_tenancy} where all {request.principal.type = 'serviceconnector', request.principal.compartment.id = '${var.compartment_id}', target.compartment.id in ('${var.compartment_id}')}",

    # Allow service-connector to read log-objects from its own tenancy
    "allow any-user to read logging-family in tenancy where all {request.principal.type = 'serviceconnector', request.principal.compartment.id = '${var.compartment_id}', target.compartment.id in ('${var.compartment_id}')}",

    # Allow service-connector to write in a bucket in its own compartment in its own tenancy
    "allow any-user to manage objects in compartment id ${var.compartment_id} where all {request.principal.type='serviceconnector', target.bucket.name='${var.sch_target_bucket}', request.principal.compartment.id='${var.compartment_id}'}",
  ]
}
