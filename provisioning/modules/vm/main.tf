resource "libvirt_volume" "os_image_debian" {
  name   = "${var.name}-imgdeb12.qcow2"
  pool   = var.storage_pool_image_name
  source = var.source_image
}


resource "libvirt_volume" "disk_debian_resized" {
  name           = "${var.name}_disk.qcow2"
  base_volume_id = libvirt_volume.os_image_debian.id
  pool           = var.storage_pool_disk_name
  size           = var.disk_storage
}

# Use CloudInit to add our ssh-key to the instance
resource "libvirt_cloudinit_disk" "cloudinit_debian_resized" {
  name = "cloudinit_${var.name}_resized.iso"
  pool = var.storage_pool_disk_name

  user_data = <<EOF
#cloud-config
disable_root: 0
ssh_pwauth: 1
users:
  - name: lookat
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    ssh-authorized-keys:
      - ${file("${var.ssh_public_key_path}")}
growpart:
  mode: auto
  devices: ['/']
EOF

}

resource "libvirt_domain" "domain_debian_resized" {
  name = var.name
  memory = var.memory
  vcpu = var.cpu

  cloudinit = libvirt_cloudinit_disk.cloudinit_debian_resized.id

  network_interface {
    network_name = "default"
    addresses = [var.ip_addr]
    wait_for_lease = false
  }

  # IMPORTANT
  # debian can hang if an isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why
  console {
    type = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.disk_debian_resized.id
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}