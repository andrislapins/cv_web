
KUBESPRAY-WORKING-VERSION:
- cd kubespray/
- git clone https://github.com/kubernetes-sigs/kubespray.git -b v2.26.0
- cd ./kubespray/
- source ../.venv/bin/activate
- pip install -U -r requirements.txt