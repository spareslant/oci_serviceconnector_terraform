output "log_info" {
  value = {
    log_id = oci_logging_log.data_log.id
    log_compartment_id = var.compartment_id
    log_group_id = oci_logging_log_group.data_log_group.id
  }
}
