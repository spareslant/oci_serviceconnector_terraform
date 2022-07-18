resource "oci_logging_log_group" "data_log_group" {
    compartment_id = var.compartment_id
    display_name = var.log_group_display_name
}

resource "oci_logging_log" "data_log" {
    display_name = var.log_display_name
    log_group_id = oci_logging_log_group.data_log_group.id
    log_type = var.log_type
    retention_duration = 30
}

resource "oci_logging_unified_agent_configuration" "data_ua_configuration" {
    compartment_id = var.compartment_id
    description = var.ua_configuration_description
    display_name = var.ua_configuration_display_name
    is_enabled = true
    service_configuration {
        configuration_type = var.ua_configuration_type

        destination {
            log_object_id = oci_logging_log.data_log.id
        }
        sources {
            source_type = var.ua_source_type
            name = "instances_logs"
            parser {
                parser_type = var.ua_parser_type
            }
            paths = ["/var/log/messages"]
        }
    }
    group_association {
        group_list = [var.dynamic_group_name]
    }
}
