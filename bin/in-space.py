#!/usr/bin/env python3

""" How many people currently in space """

import json, requests, sys
response = requests.get('http://api.open-notify.org/astros.json')
data = response.json()
print(data["number"])
sys.exit(0)

