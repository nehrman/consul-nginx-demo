# VMware Linux Virtual Machine Terraform Module

A Terraform module which creates Linux Virtual Machine with or without a Data Disk on VMware vSphere.

## Terraform versions

Support of Terraform 0.12 is not yet implemented.

If you are using Terraform 0.11 you can use versions `v1.*`.

## Usage

You can use this module in two different ways:

- Managing a VM without Data disk
- Managing a VM with Data Disk

### VM without Data Disk 

```hcl
module "vmware_linux_vm" {
  source            = "github.com/nehrman/terraform-vmware-linux"
  vmtemp            = "linux-template"
  instances         = "1"
  vmname            = "linux-vm"
  vmrp              = "datacenter/resources"
  vlan              = "200"
  data_disk         = "false"
  data_disk_size_gb = "20"
  dc                = "datacenter"
  ds                = "fc-datastore-1"
  ipaddress         = ["10.0.1.25"]
  ipv4submask       = "255.255.255.0"
  vmgateway         = "10.0.1.254"
  vmdns             = ["10.0.1.250"]
  tag_category      = "web"
  tag               = "web"
}
```

### VM with Data Disk 

```hcl
module "vmware_linux_vm" {
  source            = "github.com/nehrman/terraform-vmware-linux"
  vmtemp            = "linux-template"
  instances         = "1"
  vmname            = "linux-vm"
  vmrp              = "datacenter/resources"
  vlan              = "200"
  data_disk         = "true"
  data_disk_size_gb = "20"
  dc                = "datacenter"
  ds                = "fc-datastore-1"
  ipaddress         = ["10.0.1.25"]
  ipv4submask       = "255.255.255.0"
  vmgateway         = "10.0.1.254"
  vmdns             = ["10.0.1.250"]
  tag_category      = "web"
  tag               = "web"
}
```

## Authors

* **Nicolas Ehrman** - *Initial work* - [Hashicorp](https://www.hashicorp.com)
 


