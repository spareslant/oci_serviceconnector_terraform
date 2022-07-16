data "oci_identity_availability_domain" "compartment" {
  compartment_id = var.tenancy_ocid
  ad_number = var.ad_number
}

resource "tls_private_key" "vm_keys" {
  algorithm = "RSA"
}

resource "oci_core_instance" "instance" {
  availability_domain = data.oci_identity_availability_domain.compartment.name
  compartment_id = var.compartment_id
  shape = var.instance_shape
  create_vnic_details {
    subnet_id = var.subnet_id
  }
  display_name = var.instance_display_name
  extended_metadata = {
    ssh_authorized_keys = tls_private_key.vm_keys.public_key_openssh
  }
  source_details {
    source_id = var.image_id
    source_type = "image"
  }
}

resource "local_file" "pem_file" {
  filename             = pathexpand("./vm_keys/private_key")
  file_permission      = "600"
  directory_permission = "700"
  sensitive_content    = tls_private_key.vm_keys.private_key_pem
  depends_on           = [tls_private_key.vm_keys]
}
