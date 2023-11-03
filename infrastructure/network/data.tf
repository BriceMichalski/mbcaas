data "sops_file" "secrets" {
  source_file = "secrets.sops.yaml"
}

data "unifi_ap_group" "default" {
}

data "unifi_user_group" "default" {
}
