---
theme:
  override:
    code:
      alignment: left
      background: false
---

Introduction To Terraform For Fortigate Users
===

Welcome to this introductory guide on using Terraform with FortiGate devices. This guide is designed for FortiGate users who want to leverage Terraform to automate and manage their firewall configurations efficiently.

![](/Users/smaniak/Documents/Projects/fortigate-terraform-101/logo.png)

```bash
terraform {
  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
      version = "1.17.0"  # Use the latest version available
    }
  }
}

provider "fortios" {
  hostname = "your_fortigate_ip"
  token    = "your_fortigate_api_token"
  insecure = true  # Set to false if using a valid SSL certificate
}
```

<!-- end_slide -->

What is Terraform?
===

Terraform is an open-source Infrastructure as Code tool developed by HashiCorp. It allows you to define, provision, and manage infrastructure across various cloud providers and services using a declarative configuration language known as HCL—HashiCorp Configuration Language."


<!-- column_layout: [1, 1] -->

<!-- column: 0 -->

```bash
resource "fortios_system_interface" "port2" {
  name        = "port2"
  ip          = "192.168.2.1 255.255.255.0"
  allowaccess = ["ping", "https", "ssh"]
  type        = "physical"
  role        = "lan"
}
```

<!-- column: 1 -->
```bash
resource "fortios_firewall_policy" "lan_to_wan" {
  policyid    = 1
  name        = "LAN to WAN"
  srcintf     = ["port2"]
  dstintf     = ["port1"]
  srcaddr     = ["all"]
  dstaddr     = ["all"]
  action      = "accept"
  schedule    = "always"
  service     = ["ALL"]
  nat         = "enable"
}
```


<!-- end_slide -->

Why Use Terraform with FortiGate?
===

There are several advantages:

* Automation: Automate repetitive tasks and reduce manual configuration errors.
* Consistency: Maintain consistent configurations across multiple devices and environments.
* Version Control: Track changes over time using systems like Git.
* Scalability: Easily manage configurations in complex and large-scale environments.
* Efficiency: Rapidly deploy and update configurations without manual intervention."

<!-- end_slide -->

Prerequisites
===

Before you begin, ensure you have the following:

* Terraform Installed: Download and install Terraform from the official website.
* FortiGate Device: Access to a FortiGate device with API access enabled.
* API Access Enabled on FortiGate: ≠Generate an API token for authentication.

<!-- end_slide -->

Basic Terraform Configuration for FortiGate
===

Now let's dive into a simple demo to get you started.

* We are going to generate the API key
* Install terraform
* Configure our provider 
* Create some terraform code.

<!-- end_slide -->
