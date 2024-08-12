terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
  }
}

provider "digitalocean" {
  token = var.token
}

data "digitalocean_project" "my_project" {
  name = var.project
}

resource "digitalocean_project_resources" "my_project_resources" {
  project = data.digitalocean_project.my_project.id
  resources = [
    digitalocean_droplet.my_server.urn,
  ]
}

resource "digitalocean_droplet" "my_server" {
  image    = "ubuntu-24-04-x64"
  name     = var.vm_configs.name
  region   = "lon1"
  size     = var.vm_configs.size
  tags     = var.vm_configs.tags
  ssh_keys = var.vm_configs.ssh_keys
}

resource "ansible_host" "host" {
  name = digitalocean_droplet.my_server.ipv4_address

}

resource "ansible_playbook" "playbook" {
  playbook   = "automata.yaml"
  name       = digitalocean_droplet.my_server.ipv4_address
  replayable = true

  extra_vars = {
    target_host = digitalocean_droplet.my_server.ipv4_address
  }
}
