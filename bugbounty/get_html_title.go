package main

import (
	"bufio"
	"crypto/tls"
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"

	"golang.org/x/net/html"
)

func getHTMLTitle(url string) (string, error) {
	// Ignore SSL errors
	tr := &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}
	client := &http.Client{Transport: tr}

	resp, err := client.Get(url)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	doc, err := html.Parse(resp.Body)
	if err != nil {
		return "", err
	}

	var extractTitle func(*html.Node) string
	extractTitle = func(n *html.Node) string {
		if n.Type == html.ElementNode && n.Data == "title" && n.FirstChild != nil {
			return n.FirstChild.Data
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			title := extractTitle(c)
			if title != "" {
				return title
			}
		}
		return ""
	}

	title := extractTitle(doc)
	if title == "" {
		return "", fmt.Errorf("Title not found")
	}
	return title, nil
}

func getTitlesFromFile(inputFile, outputFile string, verbose bool) error {
	file, err := os.Open(inputFile)
	if err != nil {
		return err
	}
	defer file.Close()

	outFile, err := os.Create(outputFile)
	if err != nil {
		return err
	}
	defer outFile.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		url := scanner.Text()
		title, err := getHTMLTitle(url)
		if err != nil {
			if verbose {
				fmt.Printf("%s: %v\n", url, err)
			}
			outFile.WriteString(fmt.Sprintf("%s: %v\n", url, err))
		} else {
			if verbose {
				fmt.Printf("%s: %s\n", url, title)
			}
			outFile.WriteString(fmt.Sprintf("%s: %s\n", url, title))
		}
	}

	if err := scanner.Err(); err != nil {
		return err
	}
	return nil
}

func main() {
	inputFile := flag.String("input", "", "path to the input file")
	outputFile := flag.String("output", "", "path to the output file")
	verbose := flag.Bool("v", false, "display output in real-time")

	flag.Parse()

	if *inputFile == "" || *outputFile == "" {
		flag.PrintDefaults()
		os.Exit(1)
	}

	err := getTitlesFromFile(*inputFile, *outputFile, *verbose)
	if err != nil {
		log.Fatal(err)
	}
}
