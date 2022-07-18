variable "tenancy_ocid" {}
variable "region" {}
variable "profile_name" {}

variable "user_name" {
  default = "tf-user"
}
variable "user_description" {
  default = "TF User"
}
variable "group_name" {
  default = "tf-group"
}
variable "group_description" {
  default = "TF Group"
}
variable "compartment_name" {
  default = "TFC"
}
variable "compartment_description" {
  default = "TF compartment"
}
variable "policy_name" {
  default = "tf_policy"
}
variable "policy_description" {
  default = "TF Policy"
}
variable "vcn_cidr_blocks" {
  default = ["10.0.0.0/16"]
}
variable "vcn_display_name" {
  default = "TF_VCN"
}
variable "internet_gateway_display_name" {
  default = "TF_GATEWAY"
}
variable "route_table_display_name" {
  default = "TF_ROUTE_TABLE"
}
variable "subnet_display_name" {
  default = "TF_PUBLIC_SUBNET"
}
variable "subnet_cidr_block" {
  default = "10.0.0.0/24"
}
variable "ad_number" {
  default = 1
}
variable "instance_shape" {
  default = "VM.Standard.E2.1.Micro"
}
variable "instance_display_name" {
  default = "TF_INSTANCE"
}
variable "image_id" {
  default = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaacwqra6qcg5iil3pwqdmtorw37prkvxaw4xql6fxt6gx4lp2diyoa"
}
variable "data_bucket_name" {
  default = "data_collection_bucket"
}
variable "logging_dynamic_group_name" {
  default = "logging_dynamic_group"
}
variable "logging_dynamic_group_description" {
  default = "Logging Dynamic Group"
}

# ======== Service Connector Hub variables ========#
variable "sc_hub_name" {
  default = "DataCollectionServiceConnectorHub"
}
variable "sc_source_kind" {
  default = "monitoring"
}
variable "sc_source_mon_sources_ns_details_kind" {
  default = "selected"
}
variable "sc_source_mon_sources_ns_details_nsps_metrics_kind" {
  default = "all"
}
variable "sc_source_mon_sources_ns_details_nsps_ns_1" {
  default = "oci_computeagent"
}
variable "sc_source_mon_sources_ns_details_nsps_ns_2" {
  default = "oci_compute"
}
variable "sc_source_mon_sources_ns_details_nsps_ns_3" {
  default = "oci_vcn"
}
variable "sc_source_mon_sources_ns_details_nsps_ns_4" {
  default = "oci_blockstore"
}
variable "sc_source_mon_sources_ns_details_nsps_ns_5" {
  default = "oci_internet_gateway"
}
variable "sc_target_kind" {
  default = "objectStorage"
}
variable "sc_target_object_name_prefix" {
  default = "first_collection"
}
variable "sc_description" {
  default = "Data Collection Service Connector Hub"
}
variable "sc_policy_name" {
  default = "data_service_connector_policy"
}
variable "sc_policy_description" {
  default = "Data service connector policy"
}

#======= Logging ========#
variable "log_group_display_name" {
  default = "data_log_group"
}
variable "log_display_name" {
  default = "data_log"
}
variable "log_type" {
  default = "CUSTOM"
}
