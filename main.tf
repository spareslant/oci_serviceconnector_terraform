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
    tenancy_id = var.tenancy_ocid
}

module "user_and_group" {
  source = "./user_and_groups"
  providers = {
    oci.account = oci.tenancy
  }
  user_name               = var.user_name
  user_description        = var.user_description
  group_name              = var.group_name
  group_description       = var.group_description
  compartment_name        = var.compartment_name
  compartment_description = var.compartment_description
  policy_name             = var.policy_name
  policy_description      = var.policy_description
  parent_comp_id          = var.tenancy_ocid
  tenancy_name            = data.oci_identity_tenancy.data_collection_tenancy.name
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = module.user_and_group.oci_identity_user.user.id
  private_key_path = module.user_and_group.tls_private_key.user_keys.private_key_path
  fingerprint      = module.user_and_group.oci_identity_api_key.user_api_key.fingerprint
  region           = var.region
  alias            = "user"
}

module "networking" {
  source = "./networking"
  providers = {
    oci.account = oci.user
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
    oci.account = oci.user
  }
  depends_on            = [module.networking]
  compartment_id        = module.user_and_group.compartment_id
  tenancy_ocid          = var.tenancy_ocid
  ad_number             = var.ad_number
  instance_shape        = var.instance_shape
  subnet_id             = module.networking.public_subnet_id
  instance_display_name = var.instance_display_name
  image_id              = var.image_id
  tenancy_name          = data.oci_identity_tenancy.data_collection_tenancy.name
}
