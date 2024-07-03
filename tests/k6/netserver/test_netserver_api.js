import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '10s', target: 500 },
  ],
};

export default function () {
    let port = Math.floor(Math.random() * 1000);
    const data = { "data": [
        { 
            "localAddr": { "ip": "127.0.0.1", "name": "localhost" }, 
            "remoteAddr": { "ip": "192.168.0.1", "name": "remotehost" }, 
            "relation": { "mode": "udp", "port": port}, 
            "options": {} 
        }
    ] }
    let res = http.post(`http://storage.local/api/v1/netmap/records`, JSON.stringify(data))
  
    check(res, { 'status was 204': (r) => r.status == 204 });
  
    sleep(0.3)
}