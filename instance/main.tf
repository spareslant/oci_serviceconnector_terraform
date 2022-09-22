data "oci_identity_availability_domain" "compartment" {
  provider       = oci.account
  compartment_id = var.tenancy_ocid
  ad_number      = var.ad_number
}

resource "tls_private_key" "vm_keys" {
  algorithm = "RSA"
}

data "oci_core_images" "os_images" {
  provider       = oci.account
  compartment_id = var.compartment_id
  display_name   = var.os_image_name
}

resource "oci_identity_tag_namespace" "data_tag_namespace" {
  provider       = oci.account
  compartment_id = var.compartment_id
  description    = var.tag_namespace_description
  name           = var.tag_namespace_name
}

resource "oci_identity_tag" "data_tag" {
  provider         = oci.account
  description      = var.tag_description
  name             = var.tag_name
  tag_namespace_id = oci_identity_tag_namespace.data_tag_namespace.id
}

locals {
  tag_namespace = oci_identity_tag_namespace.data_tag_namespace.name
  tag_key       = oci_identity_tag.data_tag.name
  tag_value     = "logging_source"
}

resource "oci_identity_dynamic_group" "vm_dynamic_group" {
  provider       = oci.account
  name           = var.vm_dynamic_group_name
  compartment_id = var.compartment_id
  description    = var.vm_dynamic_group_description
  matching_rule  = "All {tag.${local.tag_namespace}.${local.tag_key}.value = '${local.tag_value}', instance.compartment.id = '${var.compartment_id}' }"
}

resource "oci_core_instance" "instance" {
  provider            = oci.account
  availability_domain = data.oci_identity_availability_domain.compartment.name
  compartment_id      = var.compartment_id
  shape               = var.instance_shape
  create_vnic_details {
    subnet_id = var.subnet_id
  }
  defined_tags = { "${local.tag_namespace}.${local.tag_key}" = "${local.tag_value}" }
  display_name = var.instance_display_name
  extended_metadata = {
    ssh_authorized_keys = tls_private_key.vm_keys.public_key_openssh
  }
  source_details {
    source_id   = data.oci_core_images.os_images.images[0].id
    source_type = "image"
  }
  shape_config {
    ocpus         = 4
    memory_in_gbs = 16
  }
}

resource "local_sensitive_file" "pem_file" {
  filename             = pathexpand("./vm_keys/${var.instance_display_name}_${var.tenancy_name}_private_key")
  file_permission      = "600"
  directory_permission = "700"
  content              = tls_private_key.vm_keys.private_key_pem
  depends_on           = [tls_private_key.vm_keys]
}
