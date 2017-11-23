# Mozilla's Cipherscan Tool, Dockerized
Built in alpine

# Running
To run use `docker run -it mateothegreat/cipherscan firefox.com:443`
Example outputs:
```
[root@devops-centos-01 yomateod]# docker run -it mateothegreat/cipherscan firefox.com:443
.......................................
Target: firefox.com:443

./cipherscan: line 849: column: command not found

OCSP stapling: supported
Cipher ordering: server
Curves ordering: unknown - fallback: no
Server supports secure renegotiation
Server supported compression methods: NONE
TLS Tolerance: yes

Intolerance to:
 SSL 3.254           : PRESENT
 TLS 1.0             : absent
 TLS 1.1             : absent
 TLS 1.2             : absent
 TLS 1.3             : absent
 TLS 1.4             : absent
 ```
 # Building a Docker Image
 ```
git clone https://github.com/mateothegreat/docker-alpine-cipherscan
cd docker-alpine-cipherscan
docker build -t your/cipherscan:1.0.0 .
 ```