variable "name" {
  type = string
}

variable "disk_storage" {
  type = number
  default =  21474836480
}

variable "memory" {
  type = string 
}

variable "cpu" {
  type = number
}

variable "storage_pool_disk_name"{
  type = string 
}

variable "storage_pool_image_name" {
  type = string
  
}

variable "source_image" {
  type = string
}

variable "ssh_public_key_path" {
    type = string 
}

variable "cloud_images_path" {
    type = string
}

variable "vm_image_name" {
    type = string
}

variable "vm_storage_path" {
    type = string
}

variable "ip_addr" {
    type = string 
}