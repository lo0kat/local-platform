variable "cluster_name" {
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
    type = list(string)   
}