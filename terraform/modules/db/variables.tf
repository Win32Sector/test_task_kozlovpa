variable "name" {
    description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
    default     = "db"
}

variable "zone" {
  description = "The zone that the machine should be created in"
  default     = "europe-west2-b"
}

variable "machine_type" {
    description = "The machine type to create"
    default     = "n1-standard-1"
}


variable "boot_disk_initialize_params_size" {
    description = "The size of the image in gigabytes. If not specified, it will inherit the size of its base image."
    default     = "20"
}

variable "boot_disk_initialize_params_type" {
    description = "The GCE disk type. May be set to pd-standard or pd-ssd."
    default     = "pd-standard"
}

variable "boot_disk_initialize_params_image" {
    description = "The image from which to initialize this disk. This can be one of: the image's self_link, projects/{project}/global/images/{image}, projects/{project}/global/images/family/{family}, global/images/{image}, global/images/family/{family}, family/{family}, {project}/{family}, {project}/{image}, {family}, or {image}. If referred by family, the images names must include the family name. If they don't, use the google_compute_image data source. For instance, the image centos-6-v20180104 includes its family name centos-6. These images can be referred by family name here."
    default     = "centos-7"
}

variable "attached_disk_source" {
    description = "The name or self_link of the disk to attach to this instance."
    default     = ""
}

variable "attached_disk_device_name" {
    description = "Name with which the attached disk will be accessible under /dev/disk/by-id/"
    default     = ""
}

variable "attached_disk_mode" {
    description = "Either 'READ_ONLY' or 'READ_WRITE', defaults to 'READ_WRITE' If you have a persistent disk with data that you want to share between multiple instances, detach it from any read-write instances and attach it to one or more instances in read-only mode."
    default     = "READ_WRITE"
}

variable "prevent_destroy_volumes" {
    default     = "false"
} 

variable "network" {
    description = "The name or self_link of the network to attach this interface to. Either network or subnetwork must be provided."
    default     = "default"
}

variable "nat_ip" {
    description = "The IP address that will be 1:1 mapped to the instance's network ip. If not given, one will be generated."
    default     = ""
}

variable "ssh_user" {
    description = "User for connection to google machine"
    default     = "appuser"
}

variable "public_key_path" {
    description = "Path to file containing public key"
    default     = "~/.ssh/appuser.pub"
}

variable "private_key_path" {
    description = "Path to file containing private key"
    default     = "~/.ssh/appuser"
}

variable "attached_disk_name" {
    description = "Name of attached disk"
    default     = "db-disk"
}

variable "attached_disk_type" {
    description = "Type of attached disk"
    default     = "pd-standard"
}

variable "attached_disk_size" {
    description = "Size of attached disk"
    default     = "50"
}

variable "install_script_src_path" {
    description = "Path to script"
    default     = "./script.sh"    
}