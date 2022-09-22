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
variable "sch_hub_name" {}
variable "sch_source_kind" {}
variable "sch_target_kind" {}
variable "sch_target_object_name_prefix" {}
variable "sch_description" {}
variable "sch_policy_name" {}
variable "sch_policy_description" {}
variable "other_tenancy_log_info" {}
variable "logs_tenancy" {}
variable "logs_tenancy_id" {}

#======= Logging ========#
variable "log_group_display_name" {}
variable "log_display_name" {}
variable "log_type" {}
variable "ua_configuration_description" {}
variable "ua_configuration_display_name" {}
variable "ua_configuration_type" {}
variable "ua_source_type" {}
variable "ua_parser_type" {}
