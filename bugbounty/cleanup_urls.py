import re
import sys

def extract_urls_from_file(file_path):
    with open(file_path, 'r') as file:
        content = file.read()
        urls = re.findall(r'(https?://\S+)', content)
        cleaned_urls = [re.sub(r'[^\w\s]+$', '', url) for url in urls]
        return cleaned_urls

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Please provide the file path as an argument.")
        sys.exit(1)
        
    file_path = sys.argv[1]
    urls = extract_urls_from_file(file_path)

    # Print the extracted URLs without special characters at the end
    for url in urls:
        print(url)
