output "log_info" {
  value = {
    log_id = oci_logging_log.data_log.id
    log_compartment_id = oci_logging_log_group.data_log_group.id
    log_group_id = var.compartment_id
  }
}
