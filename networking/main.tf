resource "oci_core_vcn" "vcn" {
  compartment_id = var.compartment_id
  cidr_blocks = var.vcn_cidr_blocks
  display_name = var.vcn_display_name
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.compartment_id
  vcn_id = oci_core_vcn.vcn.id
  enabled = true
  display_name = var.internet_gateway_display_name
}

resource "oci_core_route_table" "route_table" {
  compartment_id = var.compartment_id
  vcn_id = oci_core_vcn.vcn.id
  display_name = var.route_table_display_name
  route_rules {
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_dhcp_options" "dhcp_options" {
  compartment_id = var.compartment_id
  options {
    type = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }
  vcn_id = oci_core_vcn.vcn.id
}

resource "oci_core_subnet" "public_subnet" {
  cidr_block = var.subnet_cidr_block
  compartment_id = var.compartment_id
  vcn_id = oci_core_vcn.vcn.id
  dhcp_options_id = oci_core_dhcp_options.dhcp_options.id
  display_name = var.subnet_display_name
}

resource "oci_core_route_table_attachment" "route_table_attachment" {
  subnet_id = oci_core_subnet.public_subnet.id
  route_table_id = oci_core_route_table.route_table.id
}
