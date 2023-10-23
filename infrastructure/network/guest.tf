
# VLAN

resource "unifi_network" "guest" {

    name    = data.sops_file.secrets.data["network.guest.name"]
    purpose = "guest"
    site = "default"

    subnet       = data.sops_file.secrets.data["network.guest.subnet"]
    vlan_id      = data.sops_file.secrets.data["network.guest.vlan"]
    dhcp_enabled = data.sops_file.secrets.data["network.guest.dhcp"]

    dhcp_start   = data.sops_file.secrets.data["network.guest.dhcp_start"]
    dhcp_stop    = data.sops_file.secrets.data["network.guest.dhcp_stop"]

    ipv6_interface_type = "none"

}


# WLAN

resource "unifi_wlan" "guest_wifi" {
    name       = data.sops_file.secrets.data["network.guest.wlan.ssid"]
    passphrase = data.sops_file.secrets.data["network.guest.wlan.passphrase"]
    security   = "wpapsk"

    network_id = resource.unifi_network.guest.id
    ap_group_ids  = [data.unifi_ap_group.default.id]
    user_group_id = data.unifi_user_group.default.id
}
