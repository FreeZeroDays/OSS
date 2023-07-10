package main

import (
	"bufio"
	"flag"
	"fmt"
	"net/http"
	"net/url"
	"os"
	"strings"
)

func main() {
	// Define command-line flags
	verbose := flag.Bool("verbose", false, "Enable verbose output")
	outputFile := flag.String("output", "results.txt", "Output file")
	inputFile := flag.String("input", "", "Input file containing URLs")

	flag.Parse()

	// Get the input file path from the -input flag
	if *inputFile == "" {
		fmt.Println("Please provide an input file using the -input flag.")
		os.Exit(1)
	}

	// Open the input file
	file, err := os.Open(*inputFile)
	if err != nil {
		fmt.Printf("Failed to open input file: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	// Create or open the output file
	output, err := os.OpenFile(*outputFile, os.O_CREATE|os.O_WRONLY|os.O_TRUNC, 0644)
	if err != nil {
		fmt.Printf("Failed to open output file: %v\n", err)
		os.Exit(1)
	}
	defer output.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		urlString := normalizeURL(scanner.Text())

		// Parse the URL
		u, err := url.Parse(urlString)
		if err != nil {
			fmt.Printf("Invalid URL: %s\n", urlString)
			continue
		}

		// Perform the HTTP request
		response, err := http.Head(u.String())
		if err != nil {
			fmt.Printf("Failed to retrieve server header for %s: %v\n", u.String(), err)
			continue
		}
		defer response.Body.Close()

		// Get the server header
		server := response.Header.Get("Server")

		// Write to the output file
		outputString := fmt.Sprintf("URL: %s\nServer: %s\n\n", u.String(), server)
		_, err = output.WriteString(outputString)
		if err != nil {
			fmt.Printf("Failed to write to output file: %v\n", err)
			os.Exit(1)
		}

		// Print verbose output if enabled
		if *verbose {
			fmt.Printf("URL: %s\nServer: %s\n\n", u.String(), server)
		}
	}

	if err := scanner.Err(); err != nil {
		fmt.Printf("Error reading input file: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("Results written to %s\n", *outputFile)
}

// Normalize the URL by adding the scheme if missing
func normalizeURL(urlString string) string {
	if !strings.HasPrefix(urlString, "http://") && !strings.HasPrefix(urlString, "https://") {
		urlString = "http://" + urlString
	}
	return urlString
}
