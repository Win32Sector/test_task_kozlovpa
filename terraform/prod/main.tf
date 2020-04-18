provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
  credentials = "${file(var.gcp_key_path)}"
}

module "vpc" {
  source        = "../modules/vpc"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  boot_disk_initialize_params_image   = "${var.image}"
}

module "web" {
  source          = "../modules/web"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  boot_disk_initialize_params_image           = "${var.image}"
}