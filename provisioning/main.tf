# resource "libvirt_volume" "os_image_debian" {
#   name   = "os_image_debian.qcow2"
#   pool   = libvirt_pool.vm_base_images.name
#   source = "${var.cloud_images_path}/${var.vm_image_name}"
# }

# resource "libvirt_volume" "disk_debian_resized" {
#   name           = "debian_disk.qcow2"
#   base_volume_id = libvirt_volume.os_image_debian.id
#   pool           = libvirt_pool.vm_storage.name
#   size           = 21474836480
                  
# }

# # Use CloudInit to add our ssh-key to the instance
# resource "libvirt_cloudinit_disk" "cloudinit_debian_resized" {
#   name = "cloudinit_debian_resized.iso"
#   pool = libvirt_pool.vm_storage.name

#   user_data = <<EOF
# #cloud-config
# disable_root: 0
# ssh_pwauth: 1
# users:
#   - name: root
#     ssh-authorized-keys:
#       - ${file("${var.ssh_public_key_path}")}
# growpart:
#   mode: auto
#   devices: ['/']
# EOF

# }

# resource "libvirt_domain" "domain_debian_resized" {
#   name = "test_vm"
#   memory = "512"
#   vcpu = 1

#   cloudinit = libvirt_cloudinit_disk.cloudinit_debian_resized.id

#   network_interface {
#     network_name = "default"
#     wait_for_lease = true
#   }

#   # IMPORTANT
#   # debian can hang if an isa-serial is not present at boot time.
#   # If you find your CPU 100% and never is available this is why
#   console {
#     type = "pty"
#     target_port = "0"
#     target_type = "serial"
#   }

#   console {
#     type = "pty"
#     target_type = "virtio"
#     target_port = "1"
#   }

#   disk {
#     volume_id = libvirt_volume.disk_debian_resized.id
#   }

#   graphics {
#     type = "spice"
#     listen_type = "address"
#     autoport = true
#   }
# }

# output "ip" {
#   value = libvirt_domain.domain_debian_resized.network_interface[0].addresses[0]
# }