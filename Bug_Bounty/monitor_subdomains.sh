# Simple script leveraging ProjectDiscovery's tooling to notify when new subdomains are found.

while true;
	do subfinder -silent -dL domains.txt -all | anew subdomains.txt | notify;
	sleep 3600
done
