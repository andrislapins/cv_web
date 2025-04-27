# 📚 CV Web Platform (🚧 Work In Progress)

Welcome to **cv-web**, my personal **portfolio and technology playground**!  
This project showcases **full-stack engineering**, **DevOps**, and **cloud-native** best practices.

---

## 🚀 Project Stack Overview

| Layer         | Tech Stack                                                                                   | Details |
|:--------------|:---------------------------------------------------------------------------------------------|:--------|
| Frontend      | [Vite](https://vitejs.dev/) + [React](https://react.dev/) + [TypeScript](https://www.typescriptlang.org/) | SPA frontend, responsive UI |
| Backend       | [Spring Boot](https://spring.io/projects/spring-boot) + Java 17                                | RESTful API, PostgreSQL |
| CI/CD         | [Argo CD](https://argo-cd.readthedocs.io/) + GitOps                                           | Kubernetes GitOps deployment |
| Infrastructure| [Terraform](https://www.terraform.io/), [Terramate](https://terramate.io/), [Hetzner Cloud](https://www.hetzner.com/cloud) | Infrastructure as Code (IaC) |
| Kubernetes    | [Kubespray](https://kubespray.io/) on Hetzner VMs                                             | Production-grade cluster setup |
| Ingress       | [K8s Gateway API](https://kubernetes.io/docs/concepts/services-networking/gateway/), [Istio Mesh](https://istio.io/latest/about/service-mesh/) | TLS, mTLS |
| Monitoring    | [Prometheus](https://prometheus.io/), [Grafana](https://grafana.com/), [Kiali](https://kiali.io/), [Loki](https://grafana.com/oss/loki/), [Tempo](https://grafana.com/oss/tempo/) | Observability stack |
| Tracing       | [OpenTelemetry](https://opentelemetry.io/) + [Tempo](https://grafana.com/oss/tempo/)           | Distributed tracing |
| Async Jobs    | [Temporal.io](https://temporal.io/)                                                           | Workflow orchestration |
| DNS & TLS     | [Cloudflare](https://www.cloudflare.com/) + [cert-manager](https://cert-manager.io/)            | Wildcard certificates, CDN |

---

## 🌍 Publicly Available Services

| Service                | URL                                                                  | Description                    | Status                     |
|:-----------------------|:--------------------------------------------------------------------|:-------------------------------|:---------------------------|
| Frontend                | [https://frontend.andrefeuille.com](https://frontend.andrefeuille.com) | React TypeScript App            | ❌ **Not deployed yet** |
| Backend API             | [https://backend.andrefeuille.com](https://backend.andrefeuille.com)   | Java Spring Boot API            | ❌ **Not deployed yet** |
| Grafana                 | [https://grafana.andrefeuille.com](https://grafana.andrefeuille.com)   | Observability dashboards        | ✅ **Online**            |
| Prometheus              | [https://prometheus.andrefeuille.com](https://prometheus.andrefeuille.com) | Metrics database            | ✅ **Online**            |
| Kiali                   | [https://kiali.andrefeuille.com](https://kiali.andrefeuille.com)       | Istio service mesh visualizer   | ✅ **Online**            |
| Argo CD                 | [https://argo-cd.andrefeuille.com](https://argo-cd.andrefeuille.com)     | GitOps CI/CD pipelines          | ✅ **Online**            |
| Bookinfo App (Demo)     | [https://bookinfo.andrefeuille.com/productpage](https://bookinfo.andrefeuille.com/productpage) | Istio microservices demo app | ✅ **Online**            |

---

## ⚡ Local Development Setup

### 1. Setup Python environment (for secret scanning)

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip setuptools wheel
pip install detect-secrets
```

🔍 **Detect leaked secrets** inside your code:

```bash
detect-secrets scan > .secrets.baseline
```

---

## 📂 Repo Structure (Important Parts)

```bash
.
├── cv-web-frontend/     # Vite + React + TypeScript frontend
├── cv-web-backend/      # Java Spring Boot backend
├── helm/                # Helm charts for frontend & backend
├── argocd/              # Argo CD GitOps configs
├── hetzner/             # Terraform IaC for Kubernetes, Istio, monitoring stack
├── kubespray/           # Kubernetes cluster setup on Hetzner
└── README.md            # You're here!
```

---

## 📊 Observability

✅ Metrics via **Prometheus**  
✅ Dashboards via **Grafana**  
✅ Distributed tracing with **OpenTelemetry** → **Tempo**  
✅ Logs aggregation with **Loki**

---

## 🚀 Why This Project?

- Showcase **Kubernetes** deployment skills
- Build a real-world **DevOps + Cloud Native** platform
- Prove proficiency in **GitOps**, **Monitoring**, **Tracing**, **IaC**, and **Microservices**

---

> 🌟 **Building for production-readiness, developer experience and scalability in mind.**  
> ❤️ Powered by open-source technologies.
