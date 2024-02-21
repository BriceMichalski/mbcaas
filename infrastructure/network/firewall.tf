data "unifi_network" "root" {
  name = "Default"
}


# COMPUTED

resource "unifi_firewall_group" "groups" {
  for_each = nonsensitive(yamldecode(data.sops_file.secrets.raw).firewall.groups)
  name = each.key
  type = each.value.type
  members = each.value.members
}

resource "unifi_firewall_rule" "group_to_group" {
  for_each = nonsensitive(yamldecode(data.sops_file.secrets.raw).firewall.rules.GROUP_TO_GROUP)

  name    = "Accept ${each.value.protocol} protocol _ '${each.value.src}' -> '${each.value.dst}'"
  action  = "accept"
  ruleset = "LAN_IN"
  rule_index = 21000 + each.value.index

  protocol = each.value.protocol
  src_firewall_group_ids = [unifi_firewall_group.groups["${each.value.src}"].id]
  dst_firewall_group_ids = [unifi_firewall_group.groups["${each.value.dst}"].id]

}

resource "unifi_firewall_rule" "group_to_adress" {
  for_each = nonsensitive(yamldecode(data.sops_file.secrets.raw).firewall.rules.GROUP_TO_ADDR)

  name    = "Accept ${each.value.protocol} protocol _ '${each.value.src}' -> '${each.value.dst}'"
  action  = "accept"
  ruleset = "LAN_IN"
  rule_index = 22000 + each.value.index

  protocol = each.value.protocol
  src_firewall_group_ids = [unifi_firewall_group.groups["${each.value.src}"].id]
  dst_address = each.value.dst

}


# HARDCODED

resource "unifi_firewall_rule" "allow_related_and_established" {
    name        = "Accept Established/Related Traffic"
    rule_index  = 20000
    ruleset     = "LAN_IN"

    action      = "accept"
    protocol    = "all"

    state_established   = true
    state_related       = true
}

resource "unifi_firewall_rule" "root_to_mbcaas" {
    name        = "Accept all protocol _ root -> rfc1918"
    rule_index  = 20001
    ruleset     = "LAN_IN"

    action      = "accept"
    protocol    = "all"

    src_network_id = data.unifi_network.root.id
    dst_firewall_group_ids = [unifi_firewall_group.groups["rfc1918"].id]
}

resource "unifi_firewall_rule" "block_inter_vlan" {
    name        = "Drop all protocol _ rfc1918 -> rfc1918"
    rule_index  = 23000
    ruleset     = "LAN_IN"

    action      = "drop"
    protocol    = "all"

    src_firewall_group_ids = [unifi_firewall_group.groups["rfc1918"].id]
    dst_firewall_group_ids = [unifi_firewall_group.groups["rfc1918"].id]
}
