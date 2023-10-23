
# VLAN

resource "unifi_network" "mbcaas" {

    name    = data.sops_file.secrets.data["network.mbcaas.name"]
    purpose = "corporate"
    site = "default"

    subnet       = data.sops_file.secrets.data["network.mbcaas.subnet"]
    vlan_id      = data.sops_file.secrets.data["network.mbcaas.vlan"]
    dhcp_enabled = data.sops_file.secrets.data["network.mbcaas.dhcp"]

    dhcp_start   = data.sops_file.secrets.data["network.mbcaas.dhcp_start"]
    dhcp_stop    = data.sops_file.secrets.data["network.mbcaas.dhcp_stop"]

    ipv6_interface_type = "none"
}


# Port Profile

resource "unifi_port_profile" "mbcaas_no_poe" {
    name = "MBCaaS VLAN - No PoE"

    native_networkconf_id = unifi_network.mbcaas.id
    dot1x_ctrl            = "auto"
    poe_mode              = "off"
    forward               = "customize"
}

resource "unifi_port_profile" "mbcaas_poe" {
    name = "MBCaaS VLAN - PoE"

    native_networkconf_id = unifi_network.mbcaas.id
    dot1x_ctrl            = "auto"
    poe_mode              = "auto"
    forward               = "customize"
}


# UDM SE Port Override

resource "unifi_device" "udm_se" {

    mac                 = "ac:8b:a9:5d:2e:0d"
    name                = "Dream Machine Special Edition"


    port_override {
        aggregate_num_ports = null
        name                = "Port 3 - truenas"
        number              = 3
        port_profile_id     = resource.unifi_port_profile.mbcaas_no_poe.id
    }

    port_override {
        name                = "Port 7 - mbcaas01"
        number              = 7
        port_profile_id     = resource.unifi_port_profile.mbcaas_no_poe.id
    }

}


# MBCaaS Devices

# locals {
#     devices = yamldecode
# }
# resource "unifi_device" "mbcaas_device" {

# }
