resource "google_compute_instance" "juice_shop_instance" {
  name         = var.app_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Ephemeral public IP
    }
  }

  metadata = {
    gce-container-declaration = <<EOF
spec:
  containers:
    - name: juice-shop
      image: bkimminich/juice-shop
      stdin: false
      tty: false
  restartPolicy: Always
EOF
  }

  tags = ["http-server"]
}

resource "google_compute_firewall" "juice-rule" {
    name = "${var.project_id}-${var.app_name}-firewall"
    network = "default"
    allow {
        protocol = "tcp"
        ports = ["3000"]
    }
    source_ranges = ["0.0.0.0/0"]
}

output "juice_shop_instance_ip" {
    value = google_compute_instance.juice_shop_instance.network_interface.0.access_config.0.nat_ip
    depends_on = [ google_compute_instance.juice_shop_instance ]
}