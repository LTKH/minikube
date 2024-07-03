# Блок тестов для тестирования api Grafana
import requests

apikey = ""
creds = "admin:password"

def test_get_health():
    resp = requests.get(f'http://alerttrap.local/-/healthy')
    assert resp.status_code == 200

def test_get_vmagent_targets():
    headers = {"X-Custom-Url": "http://vmagent:8429"}
    resp = requests.get(f'http://{creds}@alerttrap.local/api/v1/targets', headers=headers)
    assert resp.status_code == 200 
    data = resp.json() 
    assert 'data' in data
    assert 'activeTargets' in data['data']
    assert len(data['data']['activeTargets']) > 0

def test_get_vmalert_alerts():
    headers = {"X-Custom-Url": "http://vmalert:8880"}
    resp = requests.get(f'http://{creds}@alerttrap.local/api/v1/alerts', headers=headers)
    assert resp.status_code == 200 
    data = resp.json() 
    #assert 'data' in data
    #assert 'activeTargets' in data['data']
    #assert len(data['data']['activeTargets']) > 0

def test_get_alertmanager_alerts():
    headers = {"X-Custom-Url": "http://alertmanager:9093"}
    resp = requests.get(f'http://{creds}@alerttrap.local/api/v1/alerts', headers=headers)
    assert resp.status_code == 200 
    data = resp.json() 
    assert 'data' in data
    #assert 'activeTargets' in data['data']
    #assert len(data['data']['activeTargets']) > 0
