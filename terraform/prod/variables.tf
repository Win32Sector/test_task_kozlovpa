variable project {
  description = "Project ID"
  default = "molten-ruler-261712"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable gcp_key_path {
  description = "Path to the GCP key"
  default = "./key.json"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
  default = "~/.ssh/appuser.pub"
}

variable image {
  description = "Disk image"
  default     = "centos-7"
}

variable zone {
  description = "The zone that the machine should be created in"
  default     = "europe-west2-b"
}