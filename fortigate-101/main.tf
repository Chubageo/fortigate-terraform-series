terraform {
  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
      version = "1.21.1"
    }
  }
}

provider "fortios" {
  hostname = "172.16.10.1"
  token    = "cffNy873qjpkq8839H8k8srjGjpy3f"
  insecure = true  # Set to false if using a valid SSL certificate
}

resource "fortios_firewall_address" "dmz_subnet" {
  allow_routing = "disable"
  cache_ttl     = 0
  color         = 0
  end_ip        = "255.255.255.0"
  name          = "dmz_subnet"
  start_ip      = "10.10.1.0"
  subnet        = "10.10.1.0 255.255.255.0"
  type          = "ipmask"
  visibility    = "enable"
  wildcard      = "10.10.1.0 255.255.255.0"
}

resource "fortios_firewall_addrgrp" "dmz_subnet" {
  allow_routing = "disable"
  color         = 0
  exclude       = "disable"
  name          = "dmz_subnet_grp"
  visibility    = "enable"

  member {
    name = fortios_firewall_address.dmz_subnet.name
  }
}