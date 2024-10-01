variable "template_vm_name" {
  description = "Name of the template to use for creating VMs"
  type = string
}

variable "pm_tls_insecure" {
  type      =  bool
  sensitive = false
}

variable "pm_host" {
  description = "The hostname or IP of the proxmox server"
  type        = string
}

variable "pm_node_name" {
  description = "Name of the proxmox node to create the VMs on"
  type        = string
  default     = "pve"
}

variable "pm_api_token_id" {
  description = "Name of the proxmox api token"
  type        = string
  sensitive   = true
}

variable "pm_api_token_secret" {
  description = "The proxmox api token secret"
  type        = string
  sensitive   = true
}

variable "pm_ci_user" {
  description = "Cloud-init username"
  type        = string
  sensitive   = true
}

variable "pm_ci_password" {
  description = "Cloud-init password for the user"
  type        = string
  sensitive   = true
}

variable "pm_ci_sshkeys" {
  description = "Cloud-init ssh keys"
  type        = string
  sensitive   = true
}