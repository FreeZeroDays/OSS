import socket

def reverse_ip_lookup(domain):
    try:
        ip_address = socket.gethostbyname(domain)
        return ip_address
    except socket.gaierror:
        return None

def main():
    input_file = "domains.txt"  # File containing list of domains, one per line
    output_file = "reverse_ip_output.txt"  # File to save the output

    with open(input_file, "r") as f:
        domains = f.read().splitlines()

    with open(output_file, "w") as f:
        for domain in domains:
            ip_address = reverse_ip_lookup(domain)
            if ip_address:
                f.write(f"{domain}: {ip_address}\n")
            else:
                f.write(f"{domain}: No IP address found\n")

    print("Reverse IP lookup completed. Output saved to", output_file)

if __name__ == "__main__":
    main()
