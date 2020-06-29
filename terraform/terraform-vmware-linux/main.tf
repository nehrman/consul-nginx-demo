data "vsphere_datacenter" "dc" {
  name = var.dc
}
data "vsphere_datastore" "datastore" {
  name          = var.ds
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "pool" {
  name          = var.vmrp
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
  name          = var.vlan
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_virtual_machine" "template" {
  name          = var.vmtemp
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_tag_category" "category" {
  name        = var.tag_category
  cardinality = "MULTIPLE"
  description = "Managed by Terraform"

  associable_types = [
    "VirtualMachine",
  ]
}

resource "vsphere_tag" "tag" {
  name        = var.tag
  category_id = vsphere_tag_category.category.id
  description = "Managed by Terraform"
}

// Creating Linux VM with no Data Disk. Note: This is the default option!!
resource "vsphere_virtual_machine" "LinuxVM" {
  count            = var.data_disk == "false" ? var.instances : 0
  //Name of the server with index of count +1 to start from 1
  name             = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  folder           = var.vmfolder

  datastore_id = data.vsphere_datastore.datastore.id

  num_cpus  = var.cpu_number
  memory    = var.ram_size
  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
        domain    = var.vmdomain
      }

      network_interface {
        ipv4_address = element(var.ipaddress, count.index)
        ipv4_netmask = var.ipv4submask  
        }
      dns_server_list = var.vmdns
      ipv4_gateway    = var.vmgateway
    }
  }

  tags = [vsphere_tag.tag.id]

}
// Creating Linux VM with Data Disk.
resource "vsphere_virtual_machine" "LinuxVM-withDataDisk" {
  count            = var.data_disk == "true" ? var.instances : 0
  //Name of the server with index of count +1 to start from 1
  name             = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  folder           = var.vmfolder

  datastore_id = data.vsphere_datastore.datastore.id

  num_cpus  = var.cpu_number
  memory    = var.ram_size
  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
  disk {
    label            = "disk1"
    size             = var.data_disk_size_gb
    unit_number = 1
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.vmname}${count.index+1}${var.vmnamesuffix}"
        domain    = var.vmdomain
      }

      network_interface {
        ipv4_address = element(var.ipaddress, count.index)
        ipv4_netmask = var.ipv4submask      
        }
      dns_server_list = var.vmdns
      ipv4_gateway    = var.vmgateway
    }
  }

  tags = [vsphere_tag.tag.id]
  
}
