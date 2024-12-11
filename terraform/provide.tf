provider "hcloud" {
  token = var.hcloud_token != "" ? var.hcloud_token : getenv("HCLOUD_TOKEN")
}
