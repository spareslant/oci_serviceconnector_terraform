resource "oci_objectstorage_bucket" "data_bucket" {
  provider = oci.account
  compartment_id = var.compartment_id
  name = var.bucket_name
  namespace = var.bucket_namespace
}
