stack {
  name        = "08_kubernetes/05_argocd"
  description = "08_kubernetes/05_argocd"
  id          = "ef94ff76-69f9-4b11-8041-611ce2781fe8"
  after = [
    "../../05_kubespray",
    "../03_mesh"
  ]
}
