provider "digitalocean" {
	token = "INSERT TOKEN HERE"
}

resource "digitalocean_droplet" "web" {
	name = "tf-1"
	image = "debian-10-x64"
	region = "nyc1"
	size = "s-1vcpu-2gb"
	ssh_keys = [INSERT SSH KEY HERE]
}

output "ip" {
	value = "${digitalocean_droplet.web.ipv4_address}"
}
