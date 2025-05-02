
kubectl get secret $(kubectl get serviceaccount external-secrets -n external-secrets -o jsonpath='{.secrets[0].name}') \
  -n external-secrets -o jsonpath='{.data.ca\.crt}' | base64 --decode > ca.crt

kubectl get secret $(kubectl get serviceaccount external-secrets -n external-secrets -o jsonpath='{.secrets[0].name}') \
  -n external-secrets -o jsonpath='{.data.token}' | base64 --decode > token.jwt

# vault write auth/kubernetes/config \
#   --address=https://vault.andrefeuille.com \
#   kubernetes_host="https://hcloud-lb-api-server.andrefeuille.com:6443" \
#   kubernetes_ca_cert=@ca.crt \
#   token_reviewer_jwt="$(cat token.jwt)"

vault write auth/kubernetes/config \
  kubernetes_host="https://hcloud-lb-api-server.andrefeuille.com:6443" \
  kubernetes_ca_cert=@ca.crt \
  token_reviewer_jwt="$(cat token.jwt)"

vault write auth/kubernetes/role/external-secrets \
  bound_service_account_names="external-secrets" \
  bound_service_account_namespaces="external-secrets" \
  policies="read-kv" \
  ttl="24h"


path "kv/data/cv_web_dev/*" {
  capabilities = ["read"]
}

vault policy write read-kv read-kv.hcl --address=https://vault.andrefeuille.com