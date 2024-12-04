# Introduction to Terraform for FortiGate Users

Welcome to this introductory guide on using Terraform with FortiGate devices. This guide is designed for FortiGate users who want to leverage Terraform to automate and manage their firewall configurations efficiently.

## Table of Contents
1. What is Terraform?
2. Why Use Terraform with FortiGate?
3. Prerequisites
4. Setting Up Terraform for FortiGate
5. Basic Terraform Configuration for FortiGate
    * Provider Configuration
    * Configuring Interfaces
    * Setting Up Firewall Policies
6. Applying the Configuration
7. Conclusion

## What is Terraform?
Terraform is an open-source Infrastructure as Code (IaC) tool developed by HashiCorp. It allows you to define, provision, and manage infrastructure across various cloud providers and services using a declarative configuration language known as HashiCorp Configuration Language (HCL).

## Why Use Terraform with FortiGate?
Integrating Terraform with FortiGate devices offers several advantages:

* Automation: Automate repetitive tasks and reduce manual configuration errors.
* Consistency: Maintain consistent configurations across multiple devices and environments.
* Version Control: Track changes over time using version control systems like Git.
* Scalability: Easily manage configurations in complex and large-scale environments.
* Efficiency: Rapidly deploy and update configurations without manual intervention.

## Prerequisites
Before you begin, ensure you have the following:
* Terraform Installed: Download and install Terraform from the official website.
* FortiGate Device: Access to a FortiGate device with API access enabled.
* API Access Enabled on FortiGate: ≠Generate an API token for authentication.

# Create a REST API administrator:
1. On the FortiGate, go to System > Administrators and click Create New > REST API Admin.
2. Enter the Username and, optionally, enter Comments. 
3. Select an Administrator Profile.
4. We recommend that you create a new profile with minimal privileges for this terraform script:
    * In the Administrator Profile drop down click Create New.
    * Enter a name for the profile.
    * Configure the Access Permissions:
        * None: The REST API is not permitted access to the resource.
        * Read: The REST API can send read requests (HTTP GET) to the resource.
        * Read/Write: The REST API can send read and write requests (HTTP GET/POST/PUT/DELETE) to the resource.
    * Click OK.
5. nter Trusted Hosts to specify the devices that are allowed to access this FortiGate.
6. Click OK.
    * An API key is displayed. This key is only shown once, so you must copy and store it securely.


## Setting Up Terraform for FortiGate
### Provider Configuration
Create a new directory for your Terraform configuration files and navigate into it:

```bash
git clone https://github.com/maniak-academy/fortigate-terraform-101.git
cd fortigate-101
```

Initialize your Terraform environment.

```bash
terraform init
```

Create a main.tf file with the following content:

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


* hostname: Replace your_fortigate_ip with the IP address of your FortiGate device.
* token: Replace your_fortigate_api_token with the API token generated from your FortiGate device.
* insecure: Set to rue if you're using a self-signed SSL certificate.

## Basic Terraform Configuration for FortiGate
### Configuring Interfaces

Configure a network interface (e.g., port2) with the desired IP address and access settings:


```hcl
resource "fortios_system_interface" "port2" {
  name        = "port2"
  ip          = "192.168.2.1 255.255.255.0"
  allowaccess = ["ping", "https", "ssh"]
  type        = "physical"
  role        = "lan"
}
```

* name: The name of the interface (e.g., port2).
* ip: The IP address and subnet mask.
* allowaccess: Protocols allowed for management access.
* type: Interface type (physical, vlan, etc.).
* role: The role of the interface (lan, wan, etc.).

## Setting Up Firewall Policies
Create a firewall policy to allow traffic from the LAN (port2) to the WAN (port1):

```hcl
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

* policyid: A unique identifier fpor the policy.
* srcintf: Source interface(s).p∏
* dstintf: Destination interface(s).
* srcaddr: Source address(es).
* dstaddr: Destination address(es).
* action: Action to take (accept, deny).
* schedule: Time schedule (always, custom schedules).
* service: Services allowed (ALL, specific services).
* nat: Enable or disable NAT.


## Applying the Configuration
Follow these steps to apply your Terraform configuration:

1. Initialize Terraform (if you haven't already):

```bash
terraform init
```

2. Validate the Configuration:sh
```bash
terraform validate
```

3. Preview the Changes:

```bash
terraform plan
```

Review the planned actions to ensure they match your expectations.

4. Apply the Configuration

```bash
terraform apply
```

Confirm the apply action when prompted by typing yes.

# Conclusion
Congratulations! You have successfully configured your FortiGate device using Terraform. By managing your firewall configurations as code, you can easily automate deployments, maintain consistency, and track changes over time.

