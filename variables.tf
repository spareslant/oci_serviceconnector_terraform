variable "tenancy_ocid" {}
variable "region" {}
variable "profile_name" {}

# ======== group and compartment ========#
variable "user_name" {}
variable "user_description" {}
variable "group_name" {}
variable "group_description" {}
variable "compartment_name" {}
variable "compartment_description" {}
variable "policy_name" {}
variable "policy_description" {}

# ======== networking ========#
variable "vcn_cidr_blocks" {}
variable "vcn_display_name" {}
variable "internet_gateway_display_name" {}
variable "route_table_display_name" {}
variable "subnet_display_name" {}
variable "subnet_cidr_block" {}

# ======== VM instance ========#
variable "ad_number" {}
variable "instance_shape" {}
variable "instance_display_name" {}
variable "os_image_name" {}
variable "data_bucket_name" {}
variable "logging_dynamic_group_name" {}
variable "logging_dynamic_group_description" {}

# ======== Service Connector Hub variables ========#
variable "sc_hub_name" {}
variable "sc_source_kind" {}
variable "sc_source_mon_sources_ns_details_kind" {}
variable "sc_source_mon_sources_ns_details_nsps_metrics_kind" {}
variable "sc_source_mon_sources_ns_details_nsps_ns_1" {}
variable "sc_source_mon_sources_ns_details_nsps_ns_2" {}
variable "sc_source_mon_sources_ns_details_nsps_ns_3" {}
variable "sc_source_mon_sources_ns_details_nsps_ns_4" {}
variable "sc_source_mon_sources_ns_details_nsps_ns_5" {}
variable "sc_target_kind" {}
variable "sc_target_object_name_prefix" {}
variable "sc_description" {}
variable "sc_policy_name" {}
variable "sc_policy_description" {}

#======= Logging ========#
variable "log_group_display_name" {}
variable "log_display_name" {}
variable "log_type" {}
variable "ua_configuration_description" {}
variable "ua_configuration_display_name" {}
variable "ua_configuration_type" {}
variable "ua_source_type" {}
variable "ua_parser_type" {}
