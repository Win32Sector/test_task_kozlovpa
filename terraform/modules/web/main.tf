resource "google_compute_instance" "web" {

    name            = "${var.name}"
    zone            = "${var.zone}"
    machine_type    = "${var.machine_type}"
    tags            = ["http-server", "ssh-server"]

    boot_disk {
        initialize_params {
            size    = "${var.boot_disk_initialize_params_size}"
            type    = "${var.boot_disk_initialize_params_type}"
            image   = "${var.boot_disk_initialize_params_image}"
        }
    }

    network_interface {
        network             = "${var.network}"

        access_config {

          nat_ip = google_compute_address.web_ip.address
        }
    }

    connection {
        type        = "ssh"
        user        = "${var.ssh_user}"
        agent       = false
        private_key = "${file(var.private_key_path)}"
        host        = "${google_compute_instance.web.network_interface.0.access_config.0.nat_ip}"

  }

    metadata = {
        ssh-keys = "${var.ssh_user}:${file("${var.public_key_path}")}"
    }
    provisioner "local-exec" {
      command = <<EOT
        echo "webhosts"  > ../../ansible/web/inventory
        echo ${self.name} ansible_host=${google_compute_instance.web.network_interface.0.access_config.0.nat_ip} ansible_ssh_private_key_file=${var.private_key_path} ansible_ssh_user=${var.ssh_user} >> ../../ansible/web/inventory
      EOT
  }
}

resource "google_compute_address" "web_ip" {
  name = "web-ip"
}

resource "google_compute_firewall" "web" {
  name    = "http-access"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8084"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["http-server"]
}
