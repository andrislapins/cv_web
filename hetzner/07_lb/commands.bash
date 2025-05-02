
sudo apt update
sudo apt upgrade
sudo apt install -y haproxy git curl apache2-utils

ssh root@lb.andrefeuille.com

sudo vim /etc/haproxy/haproxy.cfg
# Append
# ...
frontend http
  bind *:80
  mode http
  default_backend k8s_http

frontend https
  bind *:443 accept-proxy
  mode tcp
  default_backend k8s_https

backend k8s_http
  mode http
  balance roundrobin
  server kube-node-1 172.16.0.101:32489 check
  server kube-node-2 172.16.0.102:32489 check
  server kube-node-3 172.16.0.103:32489 check

backend k8s_https
  mode tcp
  balance roundrobin
  server kube-node-1 172.16.0.101:32066 send-proxy check
  server kube-node-2 172.16.0.102:32066 send-proxy check
  server kube-node-3 172.16.0.103:32066 send-proxy check

# Restart haproxy
sudo systemctl enable haproxy
sudo systemctl restart haproxy

# HAProxy Web UI
git clone https://github.com/Aidaho12/haproxy-wi.git /opt/haproxy-wi
cd /opt/haproxy-wi
sudo bash install.sh --install


kubectl patch svc istio-gateway-istio -n istio-system --patch '{
  "metadata": {
    "annotations": {
      "service.beta.kubernetes.io/aws-load-balancer-proxy-protocol": "*"
    }
  }
}'