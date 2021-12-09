provider "digitalocean" {
	token = "TOKEN"
}

resource "digitalocean_droplet" "web" {
	name = "tf-1"
	image = "debian-10-x64"
	region = "nyc1"
	size = "s-1vcpu-2gb"
	ssh_keys = [SSH_KEY]
}

output "ip" {
	value = "${digitalocean_droplet.web.ipv4_address}"
}
