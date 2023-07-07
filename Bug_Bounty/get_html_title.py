import argparse
import requests
from bs4 import BeautifulSoup

def get_html_title(url):
    try:
        response = requests.get(url)
        response.raise_for_status()
        soup = BeautifulSoup(response.content, 'html.parser')
        title = soup.title.string.strip()
        return title
    except (requests.RequestException, AttributeError):
        return None

def get_titles_from_file(input_file, output_file, verbose):
    with open(input_file, 'r') as file:
        with open(output_file, 'w') as output:
            for line in file:
                url = line.strip()
                title = get_html_title(url)
                if title:
                    result = f"{url}: {title}\n"
                else:
                    result = f"{url}: Title not found\n"

                if verbose:
                    print(result)
                
                output.write(result)

# Create argument parser
parser = argparse.ArgumentParser(description='Fetch HTML titles from a list of websites.')
parser.add_argument('input_file', help='path to the input file')
parser.add_argument('output_file', help='path to the output file')
parser.add_argument('-v', '--verbose', action='store_true', help='display output in real-time')

# Print help menu if no arguments are provided
if len(sys.argv) == 1:
    parser.print_help(sys.stderr)
    sys.exit(1)

# Parse the command-line arguments
args = parser.parse_args()

# Execute the script
get_titles_from_file(args.input_file, args.output_file, args.verbose)
