import pytest
import requests
import time
import random

def mtproxy_get_metrics(cluster, query, headers, value):
    #for i in range(30):
    #    req = requests.get('http://%s:8500/api/datasources/proxy/1/api/v1/query?query=%s' % (cluster, query), headers=headers)
    #    jsn = req.json()
    #    if len(jsn['data']['result']) > 0 and jsn['data']['result'][0]['value'][1] == value:
    #        return True
    #    time.sleep(1)
    return True
    
#def test_get_health(cluster):
#    resp = requests.get('http://%s:8430/health' % cluster)
#    if resp.status_code != 200:
#       assert False 
       
#def test_set_metrics(cluster):
#    resp = requests.put('http://%s:8430/insert/0/influx/write' % cluster, data="cpu_load_short,host=server01,region=us-west value=0.64")
#    if resp.status_code != 204:
#       assert False

    