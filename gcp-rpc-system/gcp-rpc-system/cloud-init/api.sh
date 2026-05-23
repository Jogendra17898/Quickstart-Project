#!/bin/bash

apt-get update -y
apt-get install -y python3 python3-pip

pip3 install flask requests

cat <<EOF > /home/ubuntu/api.py
from flask import Flask, request
import requests

app = Flask(__name__)

ENGINE = "http://10.0.2.10:6000"

@app.route("/inference", methods=["POST"])
def inference():
    return requests.post(
        ENGINE + "/process",
        json=request.json
    ).json()

@app.route("/health")
def health():
    return {"status":"ok"}

app.run(host="0.0.0.0", port=8000)
EOF

nohup python3 /home/ubuntu/api.py > /home/ubuntu/api.log 2>&1 &