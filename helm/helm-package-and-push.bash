#!/bin/bash

# Package the Helm charts
helm package cv-web-backend
helm package cv-web-frontend

# Push the packaged charts to a Helm repository or registry (example: GHCR)
helm push cv-web-backend-*.tgz ghcr.io/andrislapins/helm-charts
helm push cv-web-frontend-*.tgz ghcr.io/andrislapins/helm-charts
