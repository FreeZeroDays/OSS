package main

import (
	"bufio"
	"crypto/tls"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
	"regexp"
	"strings"
)

func main() {
	// Define command-line flags
	inputFile := flag.String("input", "", "Input file containing a list of URLs")
	outputFile := flag.String("output", "", "Output file to store the harvested information")
	verbose := flag.Bool("verbose", false, "Enable verbose mode")
	flag.Parse()

	// Check if input file is provided
	if *inputFile == "" {
		log.Fatal("Please provide an input file with a list of URLs")
	}

	// Open input file
	file, err := os.Open(*inputFile)
	if err != nil {
		log.Fatalf("Failed to open input file: %v", err)
	}
	defer file.Close()

	// Read URLs from input file
	urls, err := readURLs(file)
	if err != nil {
		log.Fatalf("Failed to read URLs from input file: %v", err)
	}

	// Open output file
	output, err := os.Create(*outputFile)
	if err != nil {
		log.Fatalf("Failed to create output file: %v", err)
	}
	defer output.Close()

	// Enable/disable verbose logging
	if *verbose {
		log.SetOutput(os.Stdout)
	} else {
		log.SetOutput(ioutil.Discard)
	}

	// Iterate over URLs and harvest information
	for _, u := range urls {
		log.Printf("Processing URL: %s\n", u)

		// Ignore SSL errors
		http.DefaultTransport.(*http.Transport).TLSClientConfig = &tls.Config{InsecureSkipVerify: true}

		// Make GET request to URL
		response, err := http.Get(u)
		if err != nil {
			log.Printf("Failed to make request: %v\n", err)
			continue
		}
		defer response.Body.Close()

		// Read HTML response
		body, err := ioutil.ReadAll(response.Body)
		if err != nil {
			log.Printf("Failed to read response body: %v\n", err)
			continue
		}

		// Extract important information (API keys, passwords, etc.)
		harvestedInfo := extractInfo(string(body))

		// Write harvested information to output file
		if _, err := fmt.Fprintf(output, "URL: %s\n%s\n\n", u, harvestedInfo); err != nil {
			log.Printf("Failed to write harvested information to output file: %v\n", err)
		}
	}

	log.Println("Harvesting completed")
}

// readURLs reads URLs from the input file
func readURLs(file *os.File) ([]string, error) {
	var urls []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if line != "" {
			urls = append(urls, line)
		}
	}
	if err := scanner.Err(); err != nil {
		return nil, err
	}
	return urls, nil
}

// extractInfo extracts important information (API keys, passwords, etc.) from the HTML content
func extractInfo(html string) string {
	// Regular expressions for password hashes, API keys, and passwords
	passwordHashRegex := regexp.MustCompile(`[0-9a-fA-F]{32,}`)
	apiKeyRegex := regexp.MustCompile(`[A-Za-z0-9]{32,}`)
	passwordRegex := regexp.MustCompile(`(?i)(password)\s*=\s*(['"]?)([^'"& ]{6,})(['"]?)`)

	var extractedInfo []string

	// Extract password hashes
	passwordHashes := passwordHashRegex.FindAllString(html, -1)
	for _, hash := range passwordHashes {
		extractedInfo = append(extractedInfo, "Password Hash: "+hash)
	}

	// Extract API keys
	apiKeys := apiKeyRegex.FindAllString(html, -1)
	for _, key := range apiKeys {
		extractedInfo = append(extractedInfo, "API Key: "+key)
	}

	// Extract passwords
	passwords := passwordRegex.FindAllStringSubmatch(html, -1)
	for _, match := range passwords {
		if len(match) >= 4 {
			extractedInfo = append(extractedInfo, "Password: "+match[3])
		}
	}

	// Join extracted information with line breaks
	return strings.Join(extractedInfo, "\n")
}
