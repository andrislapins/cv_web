#!/bin/bash

detect-secrets scan \
    --exclude-files "hetzner/08_kubernetes/15_observability/grafana_dashboards/.*\.json" > .secrets.baseline