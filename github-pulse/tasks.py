#!/usr/bin/env python3
import gzip
import json
import requests
import pandas

from invoke import task, run

@task
def get_data(ctx):
    """Download github events and parse json to csv."""
    src = 'http://data.githubarchive.org/{key}.json.gz'
    dst = 'githubarchive/data-raw/{key}.csv'
    key = '2015-01-01-15'

    response = requests.get(src.format(key=key))
    blob = gzip.decompress(response.content).decode('utf-8')
    activity = pandas.DataFrame({'events': blob.splitlines()})

    activity['data'] = activity.events.apply(json.loads)
    activity['type'] = activity.data.apply(lambda x: x['type'])

    activity.to_csv(dst.format(key=key), index=False)

@task
def save_as(ctx):
    """Run the save-as.R script in the githubarchive R pkg."""
    run('cd githubarchive && Rscript data-raw/save-as.R')
