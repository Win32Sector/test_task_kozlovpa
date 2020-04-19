
resource "google_compute_instance" "db" {

    name            = "${var.name}"
    zone            = "${var.zone}"
    machine_type    = "${var.machine_type}"
    tags            = ["ssh-server"]

    boot_disk {
        initialize_params {
            size    = "${var.boot_disk_initialize_params_size}"
            type    = "${var.boot_disk_initialize_params_type}"
            image   = "${var.boot_disk_initialize_params_image}"
        }
    }

    attached_disk {
        source                  = "${google_compute_disk.db-disk.self_link}"

    }

    network_interface {
        network             = "${var.network}"

        access_config {

          nat_ip = google_compute_address.db_ip.address
        }
    }

    connection {
        type        = "ssh"
        user        = "${var.ssh_user}"
        agent       = false
        private_key = "${file(var.private_key_path)}"
        host        = "${google_compute_instance.db.network_interface.0.access_config.0.nat_ip}"
  }

    metadata = {
        ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
    }

    provisioner "remote-exec" {
    script = "../modules/db/script.sh"
  }

    provisioner "local-exec" {
      command = <<EOT
        echo [${self.name}]  > ../../ansible/db/inventory
        echo ${self.name} ansible_host=${google_compute_instance.db.network_interface.0.access_config.0.nat_ip} ansible_ssh_private_key_file=${var.private_key_path} ansible_ssh_user=${var.ssh_user} >> ../../ansible/db/inventory
        echo db ansible_host=${google_compute_instance.db.network_interface.0.network_ip} ansible_ssh_private_key_file=${var.private_key_path} ansible_ssh_user=${var.ssh_user} >> ../../ansible/web/inventory

      EOT
  }
}

resource "google_compute_disk" "db-disk" {
        name = "db-disk"
        type = "pd-standard"
        zone = "europe-west2-b"
        size = "50"

        lifecycle {
                prevent_destroy = "false"
        }
}

resource "google_compute_address" "db_ip" {
  name = "db-ip"
}
