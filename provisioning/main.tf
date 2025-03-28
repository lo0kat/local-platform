module "vm" {
  count = 3
  source = "./modules/vm"
  ssh_public_key_path = var.ssh_public_key_path
  vm_image_name = var.vm_image_name
  cloud_images_path = var.cloud_images_path
  storage_pool_image_name = libvirt_pool.vm_base_images.name
  storage_pool_disk_name = libvirt_pool.vm_storage.name 
  source_image = "${var.cloud_images_path}/${var.vm_image_name}"
  vm_storage_path = var.vm_storage_path
  cpu = 2
  memory = "2048"
  name = "${var.cluster_name}-${count.index}"
  ip_addr = var.ip_addr[count.index]
}