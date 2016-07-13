#!/usr/bin/env python3
import requests
import gzip
import json

src = 'http://data.githubarchive.org/{key}.json.gz'
dst = 'githubarchive/data-raw/{key}.json'
key = '2015-01-01-15'

response = requests.get(src.format(key=key))
blob = gzip.decompress(response.content)
with open(dst.format(key=key), 'w') as out:
    out.write(blob.decode('utf-8'))
