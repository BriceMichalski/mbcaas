locals {
  secrets = yamldecode(sops_decrypt_file(("./secrets.sops.yaml")))

  nas_address  = "http://${local.secrets.nas.ip}/api/v2.0"
  nas_api_key  = local.secrets.nas.api_key
}

generate "provider" {
  path      = "provider.terragrunt.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    truenas = {
      source = "dariusbakunas/truenas"
      version = "0.11.1"
    }

    sops = {
      source = "carlpett/sops"
      version = "1.0.0"
    }
  }
}

provider "truenas" {
  api_key = "${local.nas_api_key}"
  base_url = "${local.nas_address}"
}
EOF
}
