#!/usr/bin/env python3
import gzip
import json
import requests
import pandas

src = 'http://data.githubarchive.org/{key}.json.gz'
dst = 'githubarchive/data-raw/{key}.csv'
key = '2015-01-01-15'

response = requests.get(src.format(key=key))
blob = gzip.decompress(response.content).decode('utf-8')
activity = pandas.DataFrame({'events': blob.splitlines()})

activity['data'] = activity.events.apply(json.loads)
activity['type'] = activity.data.apply(lambda x: x['type'])

activity.to_csv(dst.format(key=key), index=False)
