#!/usr/bin/env python3

""" Current Bitcoin price """

import requests
import json
import sys

apiurl = 'https://api.coindesk.com/v1/bpi/currentprice.json'
response = requests.get(apiurl)
data = response.json()

price = data["bpi"]["USD"]["rate"]
price = price.replace(",", "")
price = float(price)
print("{:,.0f}".format(price))
sys.exit(0)

