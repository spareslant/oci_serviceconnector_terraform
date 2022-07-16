resource "oci_objectstorage_bucket" "data_bucket" {
    compartment_id = var.compartment_id
    name = var.bucket_name
    namespace = var.bucket_namespace
}
