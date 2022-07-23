output "instance_ip" {
  value = oci_core_instance.instance.public_ip
}

output "os_image_id" {
  value = data.oci_core_images.os_images.images[0].id
}
