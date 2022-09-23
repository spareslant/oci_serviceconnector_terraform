# use following commands to select the profile in ~/.oci/config file and run terraform
#
# export TF_VAR_config_file_profile="FRANKFURT"
# terraform plan
#
provider "oci" {
  tenancy_ocid        = var.tenancy_ocid
  config_file_profile = var.profile_name
  alias               = "tenancy"
}

provider "tls" {}
provider "local" {}

data "oci_identity_tenancy" "data_collection_tenancy" {
  provider   = oci.tenancy
  tenancy_id = var.tenancy_ocid
}

data "oci_objectstorage_namespace" "bucket_namespace" {
  provider = oci.tenancy
}

module "user_and_group" {
  source = "./user_and_groups"
  providers = {
    oci.account = oci.tenancy
  }
  user_name                         = var.user_name
  user_description                  = var.user_description
  group_name                        = var.group_name
  group_description                 = var.group_description
  compartment_name                  = var.compartment_name
  compartment_description           = var.compartment_description
  policy_name                       = var.policy_name
  policy_description                = var.policy_description
  parent_comp_id                    = var.tenancy_ocid
  tenancy_name                      = data.oci_identity_tenancy.data_collection_tenancy.name
  logging_dynamic_group_name        = var.logging_dynamic_group_name
  logging_dynamic_group_description = var.logging_dynamic_group_description
}

# # Following provider will never come into the picture, because we are using
# # export TF_VAR_config_file_profile = "FRANKFURT" to plan and run terraform.
# # env variable takes precedence over any other config.
# # All other module too will be using config from env variable.
# # https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm
# 
# # Also in Terraform, it is not possible to create dynamic providers yet. So following
# # will not work yet
# # https://discuss.hashicorp.com/t/is-anyone-aware-of-how-to-instantiate-dynamic-providers/34776
# provider "oci" {
#   tenancy_ocid     = var.tenancy_ocid
#   user_ocid        = module.user_and_group.oci_identity_user.user.id
#   private_key_path = module.user_and_group.tls_private_key.user_keys.private_key_path
#   fingerprint      = module.user_and_group.oci_identity_api_key.user_api_key.fingerprint
#   region           = var.region
#   alias            = "user"
# }
# 
module "networking" {
  source = "./networking"
  providers = {
    oci.account = oci.tenancy
  }
  depends_on                    = [module.user_and_group]
  compartment_id                = module.user_and_group.compartment_id
  vcn_cidr_blocks               = var.vcn_cidr_blocks
  vcn_display_name              = var.vcn_display_name
  internet_gateway_display_name = var.internet_gateway_display_name
  route_table_display_name      = var.route_table_display_name
  subnet_cidr_block             = var.subnet_cidr_block
  subnet_display_name           = var.subnet_display_name
}

module "instance" {
  source = "./instance"
  providers = {
    oci.account = oci.tenancy
  }
  depends_on                   = [module.networking]
  compartment_name               = var.compartment_name
  compartment_id               = module.user_and_group.compartment_id
  tenancy_ocid                 = var.tenancy_ocid
  ad_number                    = var.ad_number
  instance_shape               = var.instance_shape
  subnet_id                    = module.networking.public_subnet_id
  instance_display_name        = var.instance_display_name
  os_image_name                = var.os_image_name
  tenancy_name                 = data.oci_identity_tenancy.data_collection_tenancy.name
  tag_namespace_name           = var.tag_namespace_name
  tag_namespace_description    = var.tag_namespace_description
  tag_name                     = var.tag_name
  tag_description              = var.tag_description
  vm_dynamic_group_name        = var.vm_dynamic_group_name
  vm_dynamic_group_description = var.vm_dynamic_group_description
}

module "data_bucket" {
  source = "./data_bucket"
  providers = {
    oci.account = oci.tenancy
  }
  depends_on       = [module.user_and_group]
  compartment_id   = module.user_and_group.compartment_id
  bucket_name      = var.data_bucket_name
  bucket_namespace = data.oci_objectstorage_namespace.bucket_namespace.namespace
}

module "connector_hub" {
  source = "./connector_hub"
  providers = {
    oci.account = oci.tenancy
  }
  depends_on                    = [module.data_bucket]
  compartment_id                = module.user_and_group.compartment_id
  tenancy_ocid                  = var.tenancy_ocid
  sch_hub_name                  = var.sch_hub_name
  sch_source_kind               = var.sch_source_kind
  sch_target_kind               = var.sch_target_kind
  sch_target_bucket             = module.data_bucket.bucket_name
  sch_target_object_name_prefix = var.sch_target_object_name_prefix
  sch_description               = var.sch_description
  compartment_name              = var.compartment_name
  logs_tenancy                  = var.logs_tenancy
  logs_tenancy_id               = var.logs_tenancy_id
  #all_logs_info                 = [var.other_tenancy_log_info]
  all_logs_info                 = [ module.logging.log_info ]

}

module "logging" {
  source = "./logging"
  # module will not be using following provider as we are using config from env variable.
  # env takes precedence over all other options.
  # https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm
  providers = {
    oci.account = oci.tenancy
  }
  depends_on                    = [module.user_and_group]
  compartment_id                = module.user_and_group.compartment_id
  log_group_display_name        = var.log_group_display_name
  log_display_name              = var.log_display_name
  log_type                      = var.log_type
  ua_configuration_description = var.ua_configuration_description
  ua_configuration_display_name = var.ua_configuration_display_name
  ua_configuration_type = var.ua_configuration_type
  ua_source_type  = var.ua_source_type
  ua_parser_type  = var.ua_parser_type
  dynamic_group_name = module.user_and_group.dynamic_group_name
}
