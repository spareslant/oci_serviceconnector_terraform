output "api_key_private" {
  value     = tls_private_key.user_keys.private_key_pem
  sensitive = true
}
output "api_key_fingerprint" {
  value = oci_identity_api_key.user_api_key.fingerprint
}

output "compartment_id" {
  value = oci_identity_compartment.compartment.id
}
