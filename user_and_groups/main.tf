resource "oci_identity_user" "user" {
  provider = oci.account
  compartment_id = var.parent_comp_id
  description    = var.user_description
  name           = var.user_name
}

resource "oci_identity_group" "group" {
  provider = oci.account
  compartment_id = var.parent_comp_id
  description    = var.group_description
  name           = var.group_name
}

resource "oci_identity_user_group_membership" "user_group_membership" {
  provider = oci.account
  group_id = oci_identity_group.group.id
  user_id  = oci_identity_user.user.id
}

resource "oci_identity_compartment" "compartment" {
  provider = oci.account
  compartment_id = var.parent_comp_id
  description    = var.compartment_description
  name           = var.compartment_name
}

resource "oci_identity_policy" "policy" {
  provider = oci.account
  compartment_id = var.parent_comp_id
  description    = var.policy_description
  name           = var.policy_name
  statements = [
    "Allow group ${var.group_name} to manage all-resources in compartment ${var.compartment_name}"
  ]
  depends_on = [oci_identity_compartment.compartment, oci_identity_group.group]
}

resource "tls_private_key" "user_keys" {
  algorithm = "RSA"
}

resource "oci_identity_api_key" "user_api_key" {
  provider = oci.account
  key_value  = tls_private_key.user_keys.public_key_pem
  user_id    = oci_identity_user.user.id
  depends_on = [tls_private_key.user_keys, oci_identity_user.user]
}

resource "local_sensitive_file" "pem_file" {
  filename             = pathexpand("~/.oci/${var.user_name}_private_api_key_${var.tenancy_name}.pem")
  file_permission      = "600"
  directory_permission = "700"
  content              = tls_private_key.user_keys.private_key_pem
  depends_on           = [tls_private_key.user_keys, oci_identity_user.user]
}

resource "oci_identity_dynamic_group" "logging_dynamic_group" {
  provider = oci.account
    compartment_id = var.parent_comp_id
    description = var.logging_dynamic_group_description
    matching_rule = "instance.compartment.id = '${oci_identity_compartment.compartment.id}'"
    name = var.logging_dynamic_group_name
  depends_on = [oci_identity_compartment.compartment]
}
