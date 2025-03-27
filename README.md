# From browser available services

| Service      | URL                                            | Description                            |
| ------------ | ---------------------------------------------- | -------------------------------------- |
| Frontend     | [http://localhost:3000](http://localhost:3000) | Vite/React/TypeScript frontend service |
| Backend      | [http://localhost:8080](http://localhost:8080) | Java/Spring backend service            |
| Grafana      | [http://localhost:3001](http://localhost:3001) | Grafana dashboard service              |
| Prometheus   | [http://localhost:9090](http://localhost:9090) | Prometheus metrics service             |
| AlertManager | [http://localhost:9093](http://localhost:9093) | Prometheus AlertManager service        |
| Temporal UI  | [http://localhost:8088](http://localhost:8088) | Temporal UI                            |

## Setup

### Detect secrets

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip setuptools wheel
pip install --upgrade urllib3 requests
pip install --upgrade detect-secrets
```
