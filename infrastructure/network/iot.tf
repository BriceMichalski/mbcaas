
# VLAN

resource "unifi_network" "iot" {

    name    = data.sops_file.secrets.data["network.iot.name"]
    purpose = "corporate"
    site = "default"

    subnet       = data.sops_file.secrets.data["network.iot.subnet"]
    vlan_id      = data.sops_file.secrets.data["network.iot.vlan"]
    dhcp_enabled = data.sops_file.secrets.data["network.iot.dhcp"]

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
