terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "acknowledge"

    workspaces {
      name = "consul-nginx-demo-vmw"
    }
  }
}

