#!/usr/bin/env python

### Description:
# Used for bumping versions in ArgoCD
### Usage example:
# ./helm-values-bump.py -f values.yaml -i 1.0.0 -k imageTag

import yaml
import argparse

parser = argparse.ArgumentParser(description='Bumps image tag version.')

parser.add_argument("-f", "--values-file",   help="Values file in helm dir. Default 'values.yaml'", default="values.yaml")
parser.add_argument("-k", "--value-key",     help="Value key in yaml. Default 'backendImageTag'", default="backendImageTag")
parser.add_argument("-i", "--image-version", help="Bumps value for images", required=True)

args = parser.parse_args()

# Read the values.yaml file
with open(args.values_file, 'r') as stream:
    try:
        loaded = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print(exc)

# Modify the fields from the dict
loaded['general'][args.value_key] = args.image_version

# Save the modified values.yaml file
with open(args.values_file, 'w') as stream:
    try:
        yaml.dump(loaded, stream, default_flow_style=False)
    except yaml.YAMLError as exc:
        print(exc)