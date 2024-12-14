variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "server_type" {  #https://www.hetzner.com/cloud/
  description = "Type of Hetzner server"
  type        = string
  default     = "cx22"
}

variable "server_locations" {
  description = "Locations of the servers"
  type        = list(string)
  default     = ["nbg1", "fsn1"] # Nuremberg and Falkenstein
}

variable "node_names" {
  description = "Names of the full node"
  type        = list(string)
  default     = ["full-node-1", "full-node-2"]
}

variable "polkadot_user_password" {
  description = "Password for the polkadot user"
  type        = string
  sensitive   = true
}

variable "ssh_port" {
  type    = number
  default = 2223
}