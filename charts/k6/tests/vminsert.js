import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 1000 },
    { duration: '10s', target: 1500 },
  ],
};

export default function () {
    let port = Math.floor(Math.random() * 1000);
    let host = "hostname-${Math.floor(Math.random() * 100)}.example.com";
    let lines = [
        "cpu_usage,host=${host},cpu=cpu-total active=${Math.floor(Math.random() * 25)*4}",
        "mem_used,host=${host} percent=${Math.floor(Math.random() * 25)*4}",
        "swap_used,host=${host} percent=${Math.floor(Math.random() * 25)*4}",
        "disk_used,host=${host},path=/tmp percent=${Math.floor(Math.random() * 25)*4}",
        "disk_used,host=${host},path=/usr percent=${Math.floor(Math.random() * 25)*4}",
        "procstat_lookup,host=${host},application=test,instance=1 running=${Math.floor(Math.random() * 1)}",
        "filestat,host=${host},path=/test/test/test exists=${Math.floor(Math.random() * 1)}",
    ];

    let res = http.post('http://localhost:8480/insert/0/prometheus', lines.join("\n"));
  
    check(res, { 'status was 204': (r) => r.status == 204 });
  
    sleep(0.3)
}