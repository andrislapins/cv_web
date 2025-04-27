
resource "null_resource" "bookinfo_apply" {
  provisioner "local-exec" {
    command     = "kubectl apply -f bookinfo.yaml"
    working_dir = path.module
  }
  provisioner "local-exec" {
    when        = destroy
    command     = "kubectl delete -f bookinfo.yaml || true"
    working_dir = path.module
  }
  depends_on = [
    kubernetes_namespace.ns
  ]
}

# kubectl exec -n bookinfo "$(kubectl get pod -n bookinfo -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"