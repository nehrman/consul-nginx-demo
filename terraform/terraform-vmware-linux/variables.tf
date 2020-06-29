variable "vmname" {
  description = "The name of the virtual machine used to deploy the vms"
  default     = "terraformvm"
}
variable "vmnamesuffix" {
  description = "vmname suffix after numbered index coming from instance variable"
  default = ""
}
variable "vmtemp" {
  description = "Name of the template available in the vSphere"
}
variable "data_disk_size_gb" {
  description = "Storage data disk size size"
  default     = 20
}
variable "data_disk" {
  type        = string
  description = "Set to true to add a datadisk."
  default     = "false"
}
variable "instances" {
  description = "number of instances you want deploy from the template"
  default = 1
}
variable "cpu_number" {
  description = "number of CPU (core per CPU) for the VM"
  default = 2
}
variable "ram_size" {
  description = "VM RAM size in megabytes"
  default = 4096
}
variable "vlan" {
  description = "(Required)VLAN name where the VM should be deployed"
}
variable "ipv4submask" {
  description = "ipv4 Subnet mask"
  default = 24
}
variable "ipaddress" {
  description = "host(VM) IP address in list format, support more than one IP. Should correspond to number of instances"
  type    = list
  default = [""]
}
variable "vmdomain" {
  description = "default VM domain for linux guest customization"
  default = "Development"
}
variable "dc" {
  description = "Name of the datacenter you want to deploy the VM to"
}
variable "vmrp" {
  description = "Cluster resource pool that VM will be deployed to. you use following to choose default pool in the cluster (esxi1) or (Cluster)/Resources"
}
variable "ds" {
  description = "Datastore to deploy the VM."
}
variable "vmfolder" {
  default = "Discovered virtual machine"
}
variable "vmgateway" {
  description = "VM gateway to set during provisioning"
  default = ""
}
variable "vmdns" {
  type = list
  default = []
   }

variable "tag_category" {
    description = "Used to name a tags' category on vCenter" 
    default = ""
}

variable "tag" {
    description = "Used to name a tag on vCenter"
    default = ""
}
