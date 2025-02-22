resource "libvirt_pool" "vm_base_images" {
  name = "vm_base_images"
  type = "dir"
  target {
    path = var.cloud_images_path
  }
}

resource "libvirt_pool" "vm_storage" {
  name = "vm_storage"
  type = "dir"
  target {
    path = var.vm_storage_path
  }
}