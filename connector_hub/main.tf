resource "oci_sch_service_connector" "data_service_connector" {
  compartment_id = var.compartment_id
  display_name = var.sc_hub_name
  source {
    kind = var.sc_source_kind

    monitoring_sources {
      compartment_id = var.compartment_id
      namespace_details {
        kind = var.sc_source_mon_sources_ns_details_kind
        namespaces {
          metrics {
            kind = var.sc_source_mon_sources_ns_details_nsps_metrics_kind
          }
          namespace = var.sc_source_mon_sources_ns_details_nsps_ns_1
        }
        namespaces {
          metrics {
            kind = var.sc_source_mon_sources_ns_details_nsps_metrics_kind
          }
          namespace = var.sc_source_mon_sources_ns_details_nsps_ns_2
        }
        namespaces {
          metrics {
            kind = var.sc_source_mon_sources_ns_details_nsps_metrics_kind
          }
          namespace = var.sc_source_mon_sources_ns_details_nsps_ns_3
        }
      }
    }
  }
  target {
      kind = var.sc_target_kind
      bucket = var.sc_target_bucket
      compartment_id = var.compartment_id
      object_name_prefix = var.sc_target_object_name_prefix
  }
  description = var.sc_description
}
