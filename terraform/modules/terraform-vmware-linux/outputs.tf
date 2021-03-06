output "dc_id" {
  description = "id of vSphere Datacenter"
  value = data.vsphere_datacenter.dc.id
}
output "respool_id" {
  description = "Resource Pool id"
  value = data.vsphere_resource_pool.pool.id
}
output "vm_name" {
  description = "VMs names deployed from all reources"
  value = concat(vsphere_virtual_machine.LinuxVM.*.name, vsphere_virtual_machine.LinuxVM-withDataDisk.*.name)
}
output "vm_ip" {
  description = "VMs IPs deployed from reource LinuxVM"
  value = concat(vsphere_virtual_machine.LinuxVM.*.default_ip_address, vsphere_virtual_machine.LinuxVM-withDataDisk.*.default_ip_address)
}