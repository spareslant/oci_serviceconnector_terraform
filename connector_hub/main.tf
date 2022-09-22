resource "oci_sch_service_connector" "data_service_connector" {
  provider       = oci.account
  compartment_id = var.compartment_id
  display_name   = var.sch_hub_name
  source {
    kind = var.sch_source_kind

    dynamic "log_sources" {
      for_each = var.all_logs_info
      iterator = log_source
      content {
        compartment_id = log_source.value.log_compartment_id
        log_group_id   = log_source.value.log_group_id
        log_id         = log_source.value.log_id
      }
    }
  }
  target {
    kind   = var.sch_target_kind
    bucket = var.sch_target_bucket
    # compartment_id = var.compartment_id
    object_name_prefix = var.sch_target_object_name_prefix
  }
  description = var.sch_description
}
