
# VLAN

resource "unifi_network" "home" {

    name    = data.sops_file.secrets.data["network.home.name"]
    purpose = "corporate"
    site = "default"

    subnet       = data.sops_file.secrets.data["network.home.subnet"]
    vlan_id      = data.sops_file.secrets.data["network.home.vlan"]
    dhcp_enabled = data.sops_file.secrets.data["network.home.dhcp"]

    dhcp_start   = data.sops_file.secrets.data["network.home.dhcp_start"]
    dhcp_stop    = data.sops_file.secrets.data["network.home.dhcp_stop"]

    multicast_dns = true
    ipv6_interface_type = "none"

}


# WLAN

resource "unifi_wlan" "home_wifi" {
    name       = data.sops_file.secrets.data["network.home.wlan.ssid"]
    passphrase = data.sops_file.secrets.data["network.home.wlan.passphrase"]
    security   = "wpapsk"

    network_id = resource.unifi_network.home.id
    ap_group_ids  = [data.unifi_ap_group.default.id]
    user_group_id = data.unifi_user_group.default.id
}
