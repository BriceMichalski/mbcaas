locals {
  secrets = yamldecode(sops_decrypt_file(("./secrets.sops.yaml")))

  unifi_controller_address  = local.secrets.unifi_controller.address
  unifi_controller_username = local.secrets.unifi_controller.username
  unifi_controller_password = local.secrets.unifi_controller.password
}

generate "provider" {
  path      = "provider.terragrunt.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    unifi = {
      source = "paultyng/unifi"
      version = "0.41.0"
    }
    sops = {
      source = "carlpett/sops"
      version = "1.0.0"
    }
  }
}

provider "unifi" {
  username = "${local.unifi_controller_username}"
  password = "${local.unifi_controller_password}"
  api_url  = "https://${local.unifi_controller_address}"

  allow_insecure = true
  site = "default"
}

EOF
}
