
# VLAN

resource "unifi_network" "iot" {

    name    = data.sops_file.secrets.data["network.iot.name"]
    purpose = "corporate"
    site = "default"

    subnet       = data.sops_file.secrets.data["network.iot.subnet"]
    vlan_id      = data.sops_file.secrets.data["network.iot.vlan"]
    dhcp_enabled = data.sops_file.secrets.data["network.iot.dhcp"]

    dhcp_start   = data.sops_file.secrets.data["network.iot.dhcp_start"]
    dhcp_stop    = data.sops_file.secrets.data["network.iot.dhcp_stop"]

    ipv6_interface_type = "none"
}


# WLAN

resource "unifi_wlan" "iot_wifi" {
    name       = data.sops_file.secrets.data["network.iot.wlan.ssid"]
    passphrase = data.sops_file.secrets.data["network.iot.wlan.passphrase"]
    security   = "wpapsk"

    network_id = resource.unifi_network.iot.id
    ap_group_ids  = [data.unifi_ap_group.default.id]
    user_group_id = data.unifi_user_group.default.id
}

# Port Profile

resource "unifi_port_profile" "iot_no_poe" {
    name = "MBCaaS VLAN - No PoE"

    native_networkconf_id = unifi_network.iot.id
    dot1x_ctrl            = "auto"
    poe_mode              = "off"
    forward               = "customize"
}
