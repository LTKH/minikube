import pytest
import requests
import time
import random

def grafana_get_metrics(query, headers, value):
    for i in range(30):
        req = requests.get('http://grafana.local/api/datasources/proxy/1/api/v1/query?query=%s' % (query), headers=headers)
        jsn = req.json()
        if len(jsn['data']['result']) > 0 and jsn['data']['result'][0]['value'][1] == value:
            return True
        time.sleep(1)
    return False
    
#def test_get_health(cluster):
#    resp = requests.get('http://storage.local/health' % cluster)
#    if resp.status_code != 200:
#       assert False 
       
#def test_get_ping(cluster):
#    resp = requests.get('http://storage.local/ping' % cluster)
#    if resp.status_code != 204:
#       assert False 
       
#def test_set_metrics(cluster):
#    resp = requests.put('http://storage.local/insert/0/influx/write' % cluster, data="cpu_load_short,host=server01,region=us-west value=0.64")
#    if resp.status_code != 204:
#       assert False
       
#def test_get_metrics(cluster):
#    value = "%.2f" % random.uniform(10.5, 75.5)
#    requests.put('http://storage.local/insert/0/influx/write', data="cpu_load_short,host=server01,region=us-west value=%s" % value)
#    grafana_headers = {'Content-Type': 'application/json', 'Authorization': 'Basic YWRtaW46cGFzc3dvcmQ='}
#    assert grafana_get_metrics('cpu_load_short_value', grafana_headers, value)