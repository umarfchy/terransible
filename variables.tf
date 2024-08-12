variable "token" {
  type    = string
  default = "REPLACE_THIS"
}

variable "project" {
  type    = string
  default = "TEST_PROJECT"
}

variable "vm_configs" {
  type = object({
    name     = string
    size     = string
    tags     = list(string)
    ssh_keys = list(string)
  })

  default = {
    name     = "vm-development"
    size     = "s-1vcpu-1gb"
    tags     = ["dev-machine"]
    ssh_keys = ["12345"]
  }
}
