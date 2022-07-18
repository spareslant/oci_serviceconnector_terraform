resource "oci_logging_log_group" "data_log_group" {
    compartment_id = var.compartment_id
    display_name = var.log_group_display_name
}

resource "oci_logging_log" "data_log" {
    display_name = var.log_display_name
    log_group_id = oci_logging_log_group.data_log_group.id
    log_type = var.log_type
}
