#!/bin/bash

# Originally from https://bertwagner.com/category/programming/command-line.html
# Modified by Adam to download data from Wordle API

USERNAME=rithwik.shivram@gmail.com
PASSWORD=Columbus1029

# Remove cookies 
rm -f cookies.txt

# Create today's date string in NYT expected format
DATE=$(date +%b%d%y)

# Parse out the CSRF auth token
AUTH_TOKEN=$(curl -c cookies.txt -b cookies.txt "https://myaccount.nytimes.com/auth/enter-email?response_type=cookie&client_id=lgcl&redirect_uri=https%3A%2F%2Fwww.nytimes.com" 2>&1 | grep -oP '(?<=authToken&quot;:&quot;).*?(?=&quot;)')

# Replace HTML encoded entities
AUTH_TOKEN=${AUTH_TOKEN//&#x3D;/=}

# First page that asks for email address
curl -c cookies.txt -b cookies.txt -X POST -d '{"email":"'$USERNAME'","auth_token":"'$AUTH_TOKEN'","form_view":"enterEmail"}' "https://myaccount.nytimes.com/svc/lire_ui/authorize-email" -H "Content-Type: application/json"

# Second page that asks for password
curl -c cookies.txt -b cookies.txt -X POST -d '{"username":"'$USERNAME'","auth_token":"'$AUTH_TOKEN'","form_view":"login","password":"'$PASSWORD'","remember_me":"Y"}' "https://myaccount.nytimes.com/svc/lire_ui/login" -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:93.0) Gecko/20100101 Firefox/93.0' -H 'Accept: application/json' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: https://myaccount.nytimes.com/auth/enter-email?response_type=cookie&client_id=lgcl&redirect_uri=https%3A%2F%2Fwww.nytimes.com' -H 'Content-Type: application/json' -H 'Req-Details: [[it:lui]]' -H 'Origin: https://myaccount.nytimes.com' -H 'DNT: 1' -H 'Connection: keep-alive' -H 'Sec-Fetch-Dest: empty' -H 'Sec-Fetch-Mode: cors' -H 'Sec-Fetch-Site: same-origin' -H 'TE: trailers'

# Download the wordle data and write it to wordle.json
curl -b cookies.txt -s "https://www.nytimes.com/svc/games/state/wordle/latest" -o wordle.json
