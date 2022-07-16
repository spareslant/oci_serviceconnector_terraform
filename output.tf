output "vm_public_ip" {
  value = module.instance.instance_ip
}

output "collection_bucket" {
  value = module.data_bucket.bucket_name
}
