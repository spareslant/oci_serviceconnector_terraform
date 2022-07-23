output "vm_public_ip" {
  value = module.instance.instance_ip
}

output "collection_bucket" {
  value = module.data_bucket.bucket_name
}

output "tenancy_name" {
  value = data.oci_identity_tenancy.data_collection_tenancy.name
}

output "os_image_id" {
  value = module.instance.os_image_id
}
