###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

#***************************
# Параметры zone&cidr
#***************************

variable "zone_a" {
  type        = string
  default     = "ru-central1-a"
}

variable "cidr_a" {
  type    = string
  default = "10.0.1.0/24"
}

variable "zone_b" {
  type        = string
  default     = "ru-central1-b"
}

variable "cidr_b" {
  type    = string
  default = "10.0.2.0/24"
}

variable "zone_c" {
  type        = string
  default     = "ru-central1-c"
}

variable "cidr_c" {
  type    = string
  default = "10.0.3.0/24"
}

#***************************
# Параметры модуля vpc_prod
#***************************

variable "env_name_prod" {
  type    = string
  default = "production"
}

#***************************
# Параметры модуля vpc_dev
#***************************

variable "env_name_dev" {
  type    = string
  default = "develop"
}

#***************************
# Параметры ВМ test-vm
#***************************

variable "env_name_vm" {
  type    = string
  default = "develop"
}

variable "test_vm_subnet_zones" {
  type        = string
  default     = "ru-central1-a"
}

variable "test_vm_instance_name" {
  type        = string
  default     = "web"
}

variable "test_vm_instance_count" {
  type        = number
  default     = 1
}

variable "test_vm_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "test_vm_public_ip" {
  type        = bool
  default     = true
}

variable "test_vm_serial_port" {
  type        = number
  default     = 1
}

#***************************
# Публичный SSH-ключ
#***************************

variable "ssh_authorized_keys" {
  type    = list(string)
  default = ["~/.ssh/id_ed25519.pub"]
}